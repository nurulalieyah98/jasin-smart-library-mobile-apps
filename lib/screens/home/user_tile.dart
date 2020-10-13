import 'package:flutter/material.dart';
import 'package:smart_library/models/users.dart';

class UserTile extends StatelessWidget {
  final Users user;
  UserTile({this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.blue[200],
            backgroundImage: AssetImage('assets/student.png'),
          ),
          title: Text(user.name + ' (' + user.id + ')'),
          subtitle: Text('Phone:' + ' ' + user.phone),
        ),
      ),
    );
  }
}
