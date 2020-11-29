import 'package:smart_library/models/users.dart';
import 'package:smart_library/screens/profile/profile_menu.dart';
import 'package:smart_library/services/auth.dart';
import 'package:smart_library/services/database.dart';
import 'package:flutter/material.dart';

class NewHome extends StatelessWidget {
  final AuthService _auth = AuthService();
  final String uid;

  NewHome({this.uid});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Users>(
      stream: DatabaseService(uid: uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Users user = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              title: Text(user.name),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.account_circle),
                  color: Colors.white,
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileMenu(uid: uid),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  color: Colors.white,
                  onPressed: () async {
                    await _auth.signOut();
                  },
                ),
              ],
            ),
          );
        } else {
          return Container(
            child: Text(uid),
          );
        }
      },
    );
  }
}
