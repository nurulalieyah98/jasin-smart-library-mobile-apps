import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:smart_library/screens/authenticate/forgot_password.dart';
import 'package:smart_library/screens/authenticate/login.dart';
import 'package:smart_library/screens/authenticate/register.dart';

class BeaconTag {
  String major;
  String minor;
  String name;

  BeaconTag(this.major, this.minor, this.name);

  @override
  String toString() {
    return '{ ${this.major}, ${this.minor}, ${this.name} }';
  }
}

class BeaconWidget extends StatefulWidget {
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

  final List<BeaconTag> _beaconTags = <BeaconTag>[
    BeaconTag('1000', '1', 'Level 1'),
    BeaconTag('1000', '2', 'Level 2'),
    BeaconTag('1000', '3', 'Level 3'),
  ];

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
      print('BluetoothState = $state');

      streamController.add(state);

      switch (state) {
        case BluetoothState.stateOn:
          initScanBeacon();
          break;
        case BluetoothState.stateOff:
          await pauseScanBeacon();
          await checkAllRequirements();
          break;
      }
    });
  }

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
    final regions = <Region>[
      Region(
        identifier: 'alieyah',
        proximityUUID: 'b9407f30-f5f8-466e-aff9-25556b57fe6a',
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
            _beacons.addAll(list);
          });
          _beacons.sort(_compareParameters);
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

  int _compareParameters(Beacon a, Beacon b) {
    int compare = a.proximityUUID.compareTo(b.proximityUUID);

    if (compare == 0) {
      compare = a.accuracy.compareTo(b.accuracy);
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
                                await flutterBeacon.openBluetoothSettings;
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
                            BeaconTag _beaconTag = _beaconTags
                                .where((b) =>
                                    b.major.contains(beacon.major.toString()))
                                .where((b) =>
                                    b.minor.contains(beacon.minor.toString()))
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
                                    _beaconTag.name,
                                    style: TextStyle(fontSize: 30.0),
                                  )
                                ],
                              )),
                              onTap: () {
                                String x = _beaconTag.name;
                                if (x == 'Level 1') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
                                  );
                                } else if (x == 'Level 2') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterUser()),
                                  );
                                } else if (x == 'Level 3') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ForgotPassword()),
                                  );
                                }
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
}
