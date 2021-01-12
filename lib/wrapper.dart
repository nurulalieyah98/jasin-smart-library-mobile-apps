import 'package:smart_library/models/users.dart';
import 'package:smart_library/screens/home/home.dart';
import 'package:smart_library/screens/authenticate/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);

    //Return either the Home or Login Page
    if (user == null) {
      return Login();
    } else {
      return Home(uid: user.uid);
    }
  }
}
