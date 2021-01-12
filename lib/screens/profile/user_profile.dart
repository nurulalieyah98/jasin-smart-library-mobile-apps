import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_library/components/card_profile.dart';
import 'package:smart_library/models/users.dart';
import 'package:smart_library/screens/profile/edit_profile.dart';
import 'package:smart_library/services/database.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  UserProfile({this.uid});

  final String uid;

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String _email, _name, _phone, _id;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Users>(
      stream: DatabaseService(uid: widget.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Users usersData = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text('Profile'),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/student.png'),
                        radius: 40.0,
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Divider(
                        thickness: 15.0,
                        color: Colors.grey,
                      ),
                      Column(
                        children: <Widget>[
                          CardProfile(
                            title: 'ID',
                            data: usersData.id,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfile(
                                    uid: widget.uid,
                                    title: 'Edit ID',
                                    hintText: 'Enter your ID',
                                    value: usersData.id,
                                  ),
                                ),
                              );
                            },
                          ),
                          CardProfile(
                            title: 'Name',
                            data: usersData.name,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfile(
                                    uid: widget.uid,
                                    title: 'Edit Name',
                                    hintText: 'Enter a name',
                                    value: usersData.name,
                                  ),
                                ),
                              );
                            },
                          ),
                          CardProfile(
                            title: 'Email',
                            data: usersData.email,
                            // onPressed: () {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => EditProfile(
                            //         uid: widget.uid,
                            //         title: 'Edit Email',
                            //         hintText: 'Enter an Email',
                            //         value: usersData.email,
                            //       ),
                            //     ),
                            //   );
                            // },
                          ),
                          CardProfile(
                            title: 'Phone Number',
                            data: usersData.phone,
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfile(
                                    uid: widget.uid,
                                    title: 'Edit Phone Number',
                                    hintText: 'Enter your phone number',
                                    value: usersData.phone,
                                  ),
                                ),
                              );
                              await DatabaseService(uid: widget.uid).userInfo(
                                _email ?? snapshot.data.email,
                                _id ?? snapshot.data.id,
                                _name ?? snapshot.data.name,
                                _phone ?? snapshot.data.phone,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return SpinKitRing(
            color: Colors.deepPurple,
          );
        }
      },
    );
  }
}
