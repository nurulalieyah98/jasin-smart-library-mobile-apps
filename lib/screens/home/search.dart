// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:smart_library/screens/books/book_level1.dart';

// class SearchBook extends StatefulWidget {
//   @override
//   _SearchBookState createState() => _SearchBookState();
// }

// class _SearchBookState extends State<SearchBook> {
//   Future<QuerySnapshot> docList;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.deepPurple[100],
//         appBar: AppBar(
//           title: Text('Search'),
//           centerTitle: true,
//           bottom: PreferredSize(
//               child: searchWidget(), preferredSize: Size(56.0, 56.0)),
//         ),
//         body: FutureBuilder<QuerySnapshot>(
//           future: docList,
//           builder: (context, snapshot) {
//             return snapshot.hasData
//                 ? ListView.builder(
//                     itemCount: snapshot.data.docs.length,
//                     itemBuilder: (context, index) {
//                       ItemModel model =
//                           ItemModel.fromJson(snapshot.data.docs[index].data);
//                       return BookLevel1(model, context);
//                     },
//                   )
//                 : Text("No data available.");
//           },
//         ),
//       ),
//     );
//   }

//   Widget searchWidget() {
//     return Container(
//       alignment: Alignment.center,
//       width: MediaQuery.of(context).size.width,
//       height: 80.0,
//       // decoration: new BoxDecoration(
//       //   gradient: new LinearGradient(
//       //     colors: [Colors.pink, Colors.lightGreenAccent],
//       //     begin: const FractionalOffset(0.0, 0.0),
//       //     end: const FractionalOffset(1.0, 0.0),
//       //     stops: [0.0, 1.0],
//       //     tileMode: TileMode.clamp,
//       //   ),
//       // ),
//       child: Container(
//         width: MediaQuery.of(context).size.width - 40.0,
//         height: 50.0,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(6.0),
//         ),
//         child: Row(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(right: 8.0),
//               child: Icon(
//                 Icons.search,
//                 color: Colors.blueGrey,
//               ),
//             ),
//             Flexible(
//               child: Padding(
//                 padding: EdgeInsets.only(right: 8.0),
//                 child: TextField(
//                   onChanged: (value) {
//                     startSearching(value);
//                   },
//                   decoration:
//                       InputDecoration.collapsed(hintText: "Search here..."),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Future startSearching(String query) {
//     docList = FirebaseFirestore.instance
//         .collection("beacons")
//         .where("shortInfo", isGreaterThanOrEqualTo: query)
//         .get();
//   }
// }
