import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_library/models/beacons.dart';
import 'package:smart_library/screens/book/book_list1.dart';
import 'package:smart_library/screens/book/book_list2.dart';
import 'package:smart_library/services/db_query.dart';

class BeaconWidget extends StatefulWidget {
  BeaconWidget({this.uid});
  final String uid;

  @override
  _BeaconWidgetState createState() => _BeaconWidgetState();
}

class _BeaconWidgetState extends State<BeaconWidget>
    with WidgetsBindingObserver {
  final StreamController<BluetoothState> streamController = StreamController();
  StreamSubscription<BluetoothState> _streamBluetooth;
  StreamSubscription<RangingResult> _streamRanging;
  final _regionBeacons = <Region, List<Beacon>>{};
  final _beacons = <Beacon>[];
  bool authorizationStatusOk = false;
  bool locationServiceEnabled = false;
  bool bluetoothEnabled = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
    /**
     * ask for permission when user open this widget
     */
    if (!authorizationStatusOk) {
      flutterBeacon.requestAuthorization;
    }

    listeningState();
  }

  listeningState() async {
    print('Listening to bluetooth state listeningState()');

    _streamBluetooth = flutterBeacon
        .bluetoothStateChanged()
        .listen((BluetoothState state) async {
      print('BluetoothState = $state'); //check state bluetooth on or not

      streamController.add(state);

      switch (state) {
        case BluetoothState
            .stateOn: //if state on the will scan the function beacon
          initScanBeacon();
          break;
        case BluetoothState
            .stateOff: //if state off the will pause scan beacon then check all the requirement
          await pauseScanBeacon();
          await checkAllRequirements();
          break;
      }
    });
  }

  //check requirement is on or off / okay or not

  checkAllRequirements() async {
    final bluetoothState = await flutterBeacon.bluetoothState;
    final bluetoothEnabled = bluetoothState == BluetoothState.stateOn;
    final authorizationStatus = await flutterBeacon.authorizationStatus;
    final authorizationStatusOk =
        authorizationStatus == AuthorizationStatus.allowed ||
            authorizationStatus == AuthorizationStatus.always;
    final locationServiceEnabled =
        await flutterBeacon.checkLocationServicesIfEnabled;

    setState(() {
      this.authorizationStatusOk = authorizationStatusOk;
      this.locationServiceEnabled = locationServiceEnabled;
      this.bluetoothEnabled = bluetoothEnabled;
    });
  }

  //if bluetooth on, this function will check to scan the beacon
  initScanBeacon() async {
    await flutterBeacon.initializeScanning;
    await checkAllRequirements();
    if (!authorizationStatusOk ||
        !locationServiceEnabled ||
        !bluetoothEnabled) {
      print('RETURNED, authorizationStatusOk=$authorizationStatusOk, '
          'locationServiceEnabled=$locationServiceEnabled, '
          'bluetoothEnabled=$bluetoothEnabled');
      return;
    }

    // region beacon
    final regions = <Region>[
      Region(
        identifier: 'alieyah',
      ),
    ];

    if (_streamRanging != null) {
      if (_streamRanging.isPaused) {
        _streamRanging.resume();
        return;
      }
    }

    _streamRanging =
        flutterBeacon.ranging(regions).listen((RangingResult result) {
//      print(result);

      if (result != null && mounted) {
        setState(() {
          _regionBeacons[result.region] = result.beacons;
          _beacons.clear();
          _regionBeacons.values.forEach((list) {
            _beacons
                .addAll(list); //all the data beacon in db will add in this list
          });
          _beacons.sort(
              _compareParameters); //compare parameter data in db n beacon device
        });
      }
    });
  }

  pauseScanBeacon() async {
    _streamRanging?.pause();
    if (_beacons.isNotEmpty) {
      setState(() {
        _beacons.clear();
      });
    }
  }

  //compare all the beacon's data in database same as in beacon device or not
  int _compareParameters(Beacon a, Beacon b) {
    int compare = a.proximityUUID.compareTo(b.proximityUUID);

    if (compare == 0) {
      compare = a.accuracy.compareTo(b.accuracy);
    }

    if (compare == 0) {
      compare = a.major.compareTo(b.major);
    }

    if (compare == 0) {
      compare = a.minor.compareTo(b.minor);
    }

//    if (compare == 0) {
//      compare = a.accuracy.compareTo(b.accuracy);
//    }

    return compare;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('AppLifecycleState = $state');

    if (state == AppLifecycleState.resumed) {
      if (_streamBluetooth != null && _streamBluetooth.isPaused) {
        _streamBluetooth.resume();
      }
      await checkAllRequirements();
      if (authorizationStatusOk && locationServiceEnabled && bluetoothEnabled) {
        await initScanBeacon();
      } else {
        await pauseScanBeacon();
        await checkAllRequirements();
      }
    } else if (state == AppLifecycleState.paused) {
      _streamBluetooth?.pause();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    streamController?.close();
    _streamRanging?.cancel();
    _streamBluetooth?.cancel();
    flutterBeacon.close;

    super.dispose();
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DBQuery().beaconList(widget.uid),
        builder: (context, snapshot) {
          List<Beacons> _beaconList = snapshot.data;
          if (snapshot.hasError || !snapshot.hasData) {
            return Container(
              color: Colors.white,
              child: SpinKitRing(
                color: Colors.deepPurple,
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.deepPurple[100],
              appBar: AppBar(
                title: Text('Book Menu'),
                centerTitle: true,
              ),
              body: Center(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        StreamBuilder<BluetoothState>(
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final state = snapshot.data;

                              if (state == BluetoothState.stateOn) {
                                return IconButton(
                                  icon: Icon(Icons.bluetooth_connected),
                                  onPressed: () {},
                                  color: Colors.lightBlueAccent,
                                );
                              }

                              if (state == BluetoothState.stateOff) {
                                return IconButton(
                                  icon: Icon(Icons.bluetooth),
                                  onPressed: () async {
                                    if (Platform.isAndroid) {
                                      try {
                                        await flutterBeacon
                                            .openBluetoothSettings;
                                      } on PlatformException catch (e) {
                                        print(e);
                                      }
                                    } else if (Platform.isIOS) {}
                                  },
                                  color: Colors.red,
                                );
                              }

                              return IconButton(
                                icon: Icon(Icons.bluetooth_disabled),
                                onPressed: () {},
                                color: Colors.grey,
                              );
                            }

                            return SizedBox.shrink();
                          },
                          stream: streamController.stream,
                          //myStreamController.stream.asBroadcastStream().listen(onData);
                          initialData: BluetoothState.stateUnknown,
                        ),
                      ],
                    ),
                    _beacons == null || _beacons.isEmpty
                        ? Center(child: CircularProgressIndicator())
                        : Expanded(
                            child: ListView(
                              children: ListTile.divideTiles(
                                  context: context,
                                  tiles: _beacons.map((beacon) {
                                    // BeaconTag _beaconTag = _beaconTags
                                    Beacons _beaconLists = _beaconList
                                        // .where((b) => b.proximityUUID.contains(
                                        //     beacon.proximityUUID.toString()))
                                        .where((b) => b.major
                                            .contains(beacon.major.toString()))
                                        .where((b) => b.minor
                                            .contains(beacon.minor.toString()))
                                        .first;
                                    return GestureDetector(
                                      child: Card(
                                          child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  '${beacon.accuracy}',
                                                  style: TextStyle(
                                                    fontSize: 80.0,
                                                    color: Colors.deepPurple,
                                                  ),
                                                ),
                                                Text('Meter')
                                              ],
                                            ),
                                          ),
                                          Text(
                                            _beaconLists.beaconName,
                                            style: TextStyle(fontSize: 30.0),
                                          )
                                        ],
                                      )),
                                      onTap: () {
                                        String x = _beaconLists.beaconName;
                                        if (x == 'Level 1') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BookList()),
                                          );
                                        } else if (x == 'Level 2') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BookList2()),
                                          );
                                        } else {
                                          return Container(
                                            color: Colors.white,
                                            child: SpinKitRing(
                                              color: Colors.deepPurple,
                                            ),
                                          );
                                        }
                                        // else if (x == 'Level 3') {
                                        //   Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             ForgotPassword()),
                                        //   );
                                        // }
                                      },
                                    );
                                  })).toList(),
                            ),
                          )
                  ],
                ),
              ),
            );
          }
        });
  }
}
