import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_library/services/DataController.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();
  QuerySnapshot snapshotData;
  bool isExcecuted = false;
  @override
  Widget build(BuildContext context) {
    Widget searchedData() {
      return ListView.builder(
        itemCount: snapshotData.docs.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.only(top: 2.0),
              child: Card(
                margin: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25.0,
                    backgroundImage:
                        NetworkImage(snapshotData.docs[index].data()['url']),
                  ),
                  title: Text(
                    snapshotData.docs[index].data()['title'],
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0),
                  ),
                  subtitle: Text(
                    snapshotData.docs[index].data()['author'] +
                        '\n' +
                        snapshotData.docs[index].data()['shelves'],
                    style: TextStyle(
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                        fontSize: 12.0),
                  ),
                ),
              ));
        },
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.clear),
          onPressed: () {
            setState(() {
              isExcecuted = false;
            });
          }),
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        actions: [
          GetBuilder<DataController>(
            init: DataController(),
            builder: (val) {
              return IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    val.queryData(searchController.text).then((value) {
                      snapshotData = value;
                      setState(() {
                        isExcecuted = true;
                      });
                    });
                  });
            },
          )
        ],
        title: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintText: 'Search Books',
              hintStyle: TextStyle(color: Colors.white)),
          controller: searchController,
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: isExcecuted
          ? searchedData()
          : Container(
              child: Center(
                child: Text(
                    'Tips: only the first word can find & \nthe first alphabet must be capitalized. \nNext, press the search button!',
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)),
              ),
            ),
    );
  }
}
