// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class SearchPage extends StatefulWidget {
//   @override
//   _SearchPageState createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   TextEditingController searchController = TextEditingController();
//   final database = FirebaseFirestore.instance;
//   final searchkey =
//       FirebaseFirestore.instance.collection('books').where('title').get();
//   String title = searchkey;
//   @override
//   Widget build(BuildContext context) {
//     List<String> splitList = title.split(' ');
//     List<String> indexList = [];

//     for (int i = 0; i < splitList.length; i++) {
//       for (int j = 0; j < splitList[i].length + i; j++) {
//         indexList.add(splitList[i].substring(0, j).toLowerCase());
//       }
//     }
//     database.collection('books').add({'searchIndex': indexList});

//     return Scaffold(
//       backgroundColor: Colors.deepPurple[100],
//       appBar: AppBar(
//         backgroundColor: Colors.deepPurple,
//         title: Text('Search Page'),
//       ),
//       body: Container(
//           child: Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: TextField(
//               controller: searchController,
//               decoration: InputDecoration(
//                   suffixIcon: IconButton(
//                     icon: Icon(Icons.clear),
//                     onPressed: () => searchController.clear(),
//                   ),
//                   hintText: 'Search Here',
//                   hintStyle:
//                       TextStyle(fontFamily: 'Antra', color: Colors.deepPurple)),
//             ),
//           )
//         ],
//       )),
//     );
//   }
// }
