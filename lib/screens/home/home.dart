import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_library/screens/home/settings_form.dart';
import 'package:smart_library/services/auth.dart';
import 'package:smart_library/services/database.dart';
import 'package:provider/provider.dart';
import 'package:smart_library/screens/home/user_list.dart';
import 'package:smart_library/models/users.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Users>>.value(
      value: DatabaseService().users,
      child: Scaffold(
        backgroundColor: Colors.deepPurple[50],
        appBar: AppBar(
          title: Text('Jasin Smart'),
          backgroundColor: Colors.deepPurple[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/library2.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: UserList()),
      ),
    );
  }
}
