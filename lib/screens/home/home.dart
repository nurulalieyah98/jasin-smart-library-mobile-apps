import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_library/models/users.dart';
import 'package:smart_library/screens/book/scan_me.dart';
import 'package:smart_library/screens/profile/user_profile.dart';
import 'package:smart_library/screens/search/search2.dart';
import 'package:smart_library/services/auth.dart';
import 'package:smart_library/services/database.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  final String uid;

  Home({this.uid});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Users>(
      stream: DatabaseService(uid: uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Users user = snapshot.data;
          return Scaffold(
              backgroundColor: Colors.deepPurple[100],
              appBar: AppBar(
                backgroundColor: Colors.deepPurple,
                title: Text('${user.name}'),
                centerTitle: true,
                leading: IconButton(
                  icon: Image.asset(
                    'assets/uitm.png',
                    height: 40,
                  ),
                  onPressed: () {},
                ), //Image.asset("assets/uitmmelaka.png"))
                actions: <Widget>[
                  // IconButton(
                  //   icon: Icon(Icons.account_circle),
                  //   color: Colors.white,
                  //   onPressed: () async {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => ProfileMenu(uid: uid),
                  //       ),
                  //     );
                  //   },
                  // ),
                  // IconButton(
                  //   icon: Icon(Icons.exit_to_app),
                  //   color: Colors.white,
                  //   onPressed: () async {
                  //     await _auth.signOut();
                  //   },
                  // ),
                  // IconButton(
                  //   icon: Icon(Icons.shopping_cart),
                  //   color: Colors.white,
                  //   onPressed: () async {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => Cart(uid: uid),
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
              body: SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Text(
                        // "Welcome To Main Menu\nJasin Smart Library",
                        "Welcome To Jasin Smart Library \n\nMain Menu",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      //padding: const EdgeInsets.all(30.0),
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: Wrap(
                          spacing: 15,
                          runSpacing: 15.0,
                          children: <Widget>[
                            SizedBox(
                              width: 160.0,
                              height: 160.0,
                              child: Card(
                                color: Color.fromARGB(255, 21, 21, 21),
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: new RaisedButton(
                                  onPressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ScanMe(),
                                      ),
                                    );
                                  },
                                  color: Color.fromARGB(255, 21, 21, 21),
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Center(
                                      child: Padding(
                                    //padding: const EdgeInsets.all(30.0),
                                    padding: const EdgeInsets.all(21.0),
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/book.png",
                                          width: 70.0,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          "Books",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0),
                                        ),
                                      ],
                                    ),
                                  )),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 160.0,
                              height: 160.0,
                              child: Card(
                                color: Color.fromARGB(255, 21, 21, 21),
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: new RaisedButton(
                                  onPressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        // builder: (context) => SearchBook(),
                                        builder: (context) => SearchPage(),
                                      ),
                                    );
                                  },
                                  color: Color.fromARGB(255, 21, 21, 21),
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(21.0),
                                    //padding: const EdgeInsets.all(30.0),
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/search.png",
                                          width: 70.0,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          "Search",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0),
                                        ),
                                      ],
                                    ),
                                  )),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 160.0,
                              height: 160.0,
                              child: Card(
                                color: Color.fromARGB(255, 21, 21, 21),
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: new RaisedButton(
                                  onPressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UserProfile(uid: uid),
                                      ),
                                    );
                                  },
                                  color: Colors.black,
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Padding(
                                    //padding: const EdgeInsets.all(30.0),
                                    padding: const EdgeInsets.all(21.0),
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/profile.png",
                                          width: 75.0,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          "Profile",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 160.0,
                              height: 160.0,
                              child: Card(
                                color: Color.fromARGB(255, 21, 21, 21),
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: new RaisedButton(
                                  onPressed: () async {
                                    await _auth.signOut();
                                  },
                                  color: Colors.black,
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Padding(
                                    //padding: const EdgeInsets.all(30.0),
                                    padding: const EdgeInsets.all(21.0),
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/logout.png",
                                          width: 70.0,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          "Logout",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )));
        } else {
          return Container(
            color: Colors.white,
            child: SpinKitRing(
              color: Colors.deepPurple,
            ),
          );
        }
      },
    );
  }
}
