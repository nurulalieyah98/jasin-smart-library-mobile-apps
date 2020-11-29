import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_library/models/users.dart';
import 'package:smart_library/screens/wrapper.dart';
import 'package:smart_library/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(JasinSmartLibrary());
}

class JasinSmartLibrary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Jasin Smart Library',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Wrapper(),
      ),
    );
  }
}
