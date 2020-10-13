import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:smart_library/models/users.dart';
import 'package:smart_library/screens/home/user_tile.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<Users>>(context) ?? [];

    // users.forEach((user) {
    //   print(user.name);
    //   print(user.id);
    //   print(user.phone);
    // });

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return UserTile(user: users[index]);
      },
    );
  }
}
