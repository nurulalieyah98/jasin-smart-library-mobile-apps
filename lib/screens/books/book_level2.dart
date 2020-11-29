import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_library/widgets/book_card2.dart';

class BookLevel2 extends StatelessWidget {
  final CollectionReference _booksRef = FirebaseFirestore.instance
      .collection("beacons")
      .doc("b9407f30-f5f8-466e-aff9-25556b57fe6b")
      .collection("level 2");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        title: Text('Book Catalogue Level 2'),
        centerTitle: true,
      ),
      body: Container(
        child: Stack(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: _booksRef.get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }

                // Collection Data ready to display
                if (snapshot.connectionState == ConnectionState.done) {
                  // Display the data inside a list view
                  return ListView(
                    padding: EdgeInsets.only(
                      top: 12.0,
                      bottom: 12.0,
                    ),
                    children: snapshot.data.docs.map((document) {
                      return BookCard2(
                        title: document.data()['title'],
                        shelves: document.data()['shelves'],
                        image: document.data()['image'][0],
                        bookID: document.id,
                      );
                    }).toList(),
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
            //   title: "Home",
            //   hasBackArrrow: false,
            // ),
          ],
        ),
      ),
    );
  }
}
