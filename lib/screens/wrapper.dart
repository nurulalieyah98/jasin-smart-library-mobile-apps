import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_library/models/user.dart';
import 'package:smart_library/screens/authenticate/authenticate.dart';
import 'package:smart_library/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
