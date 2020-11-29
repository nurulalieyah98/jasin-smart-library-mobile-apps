import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:smart_library/screens/home/beacon.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smart_library/screens/home/home.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Jasin Smart Library',
//       theme: ThemeData(
//         primarySwatch: Colors.deepPurple,
//       ),
//       home: MyHomePage(title: 'Jasin Smart Library'),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.uid}) : super(key: key);
  final String title;
  final String uid;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex;
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  final PermissionHandler permissionHandler = PermissionHandler();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = 0;

    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });
    enableBluetooth();
    requestLocationPermission();
    //_gpsService();
  }

  Future<void> enableBluetooth() async {
    // Retrieving the current Bluetooth state
    _bluetoothState = await FlutterBluetoothSerial.instance.state;

    // If the bluetooth is off, then turn it on first
    // and then retrieve the devices that are paired.
    if (_bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
      return true;
    } else {}
    return false;
  }

  ///1
  Future<bool> _requestPermission(PermissionGroup permission) async {
    final PermissionHandler _permissionHandler = PermissionHandler();
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

/*Checking if your App has been Given Permission*/
  ///2
  Future<bool> requestLocationPermission({Function onPermissionDenied}) async {
    var granted = await _requestPermission(PermissionGroup.location);
    if (granted != true) {
      requestLocationPermission();
    }
    debugPrint('requestContactsPermission $granted');
    return granted;
  }

  // void changePage(int index) {
  //   setState(() {
  //     currentIndex = index;
  //   });
  // }

  final List<Widget> _children = [
    //Home(uid: uid),
    //ExampleWidget(),
    Home(),
    BeaconWidget(),
    //Book(),
    //Recommendation(),
    //UserProfile(),
  ];

  final List<Color> _bgColor = [
    Colors.white,
    Colors.red,
    Colors.grey[40],
    //Colors.grey[40],
    //Colors.grey[40],
    //Colors.grey[40],
  ];

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
