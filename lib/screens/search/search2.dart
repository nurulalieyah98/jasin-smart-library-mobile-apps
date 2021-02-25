import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController textEditingController = TextEditingController();
  final database = FirebaseFirestore.instance;
  String searchString;

  String convertToTitleCase(String text) {
    if (text == null) {
      return null;
    }

    if (text.length <= 1) {
      return text.toUpperCase();
    }

    // Split string into multiple words
    final List<String> words = text.split(' ');

    // Capitalize first letter of each words
    final capitalizedWords = words.map((word) {
      final String firstLetter = word.substring(0, 1).toUpperCase();
      final String remainingLetters = word.substring(1);

      return '$firstLetter$remainingLetters';
    });

    // Join/Merge all words back to one String
    return capitalizedWords.join(' ');
  }
  // String getCapitalizeString({String str}) {
  //   if (str.length <= 1) {
  //     return str.toUpperCase();
  //   }
  //   return '${str[0].toUpperCase()}${str.substring(1)}';
  // }

  // String capitalize(String val) => (val != null && val.length > 1)
  //     ? val[0].toUpperCase() + val.substring(1)
  //     : val != null ? val.toUpperCase() : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        title: Text('Search'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: TextField(
                autocorrect: true,
                textCapitalization: TextCapitalization.words,
                onChanged: (val) {
                  setState(() {
                    searchString = convertToTitleCase(val);
                  });
                },
                controller: textEditingController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffix: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () => textEditingController.clear(),
                    ),
                    hintText: 'Search book title!',
                    hintStyle: TextStyle(
                        fontFamily: 'Antra', color: Colors.deepPurple)),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: (searchString == null || searchString.trim() == '')
                    ? FirebaseFirestore.instance.collection('books').snapshots()
                    : FirebaseFirestore.instance
                        .collection('books')
                        .where('title', isGreaterThanOrEqualTo: searchString)
                        .where('title',
                            isLessThanOrEqualTo: searchString + '\uf8ff')
                        .orderBy('title')
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Got an error ${snapshot.error}');
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return SizedBox(
                        child: Center(
                          child: SpinKitRing(
                            color: Colors.deepPurple,
                          ),
                        ),
                      );
                    case ConnectionState.none:
                      return Text('Opps no data present!');

                    case ConnectionState.done:
                      return Text('We are done!');

                    default:
                      return new ListView(
                        children:
                            snapshot.data.docs.map((DocumentSnapshot document) {
                          return new Card(
                            margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 25.0,
                                backgroundImage: NetworkImage(document['url']),
                              ),
                              title: Text(
                                document['title'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                              subtitle: Text(
                                document['author'] + '\n' + document['shelves'],
                                style: TextStyle(
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 12.0),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                  }
                }),
          )
        ],
      ),
    );
  }
}
