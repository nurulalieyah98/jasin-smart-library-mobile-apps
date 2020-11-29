import 'package:flutter/material.dart';
import 'package:smart_library/widgets/image_swipe.dart';
import 'package:smart_library/constants.dart';
import 'package:smart_library/services/database.dart';
import 'package:smart_library/services/auth.dart';

class BookPage2 extends StatefulWidget {
  final String bookID;
  BookPage2({this.bookID});

  @override
  _BookPage2State createState() => _BookPage2State();
}

class _BookPage2State extends State<BookPage2> {
  AuthService _auth = AuthService();
  DatabaseService _firebaseServices = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        title: Text('Book Details'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.booksRef2.doc(widget.bookID).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                // Firebase Document Data Map
                Map<String, dynamic> documentData = snapshot.data.data();

                // List of images
                List imageList = documentData['image'];

                return ListView(
                  padding: EdgeInsets.all(0),
                  children: [
                    //Image.network("${documentData['image']}"),
                    ImageSwipe(
                      imageList: imageList,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        left: 10.0,
                        right: 10.0,
                        bottom: 2.0,
                      ),
                      child: Text(
                        "${documentData['title']}",
                        style: Constants.boldHeading,
                        //textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 10.0,
                      ),
                      child: Text(
                        "Author : ${documentData['author']}",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.pink,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 10.0,
                      ),
                      child: Text(
                        "Category : ${documentData['category']}",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.pink,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 10.0,
                      ),
                      child: Text(
                        "Shelves : ${documentData['shelves']}",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.pink,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 10.0,
                      ),
                      child: Text(
                        "Synopsis: \n${documentData['synopsis']}",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              }

              // Loading State
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          // CustomActionBar(
          //   hasBackArrrow: true,
          //   hasTitle: false,
          //   hasBackground: false,
          // )
        ],
      ),
    );
  }
}
