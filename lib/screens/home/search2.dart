// import 'package:smart_library/models/books.dart';
// import 'package:smart_library/screens/home/detailscreen.dart';
// import 'package:smart_library/widgets/book_provider.dart';

// import 'package:smart_library/widgets/single_book.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class SearchBooks extends SearchDelegate<void> {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.close),
//         onPressed: () {
//           query = "";
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     BookProvider providerProvider = Provider.of<BookProvider>(context);
//     List<Books> searchCategory = providerProvider.searchBookList(query);

//     return GridView.count(
//         crossAxisCount: 2,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//         children: searchCategory
//             .map((e) => GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (ctx) => DetailScreen(
//                           url: e.url,
//                           title: e.title,
//                           author: e.author,
//                         ),
//                       ),
//                     );
//                   },
//                   child: SingleBook(
//                     url: e.url,
//                     title: e.title,
//                     author: e.author,
//                   ),
//                 ))
//             .toList());
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     BookProvider providerProvider = Provider.of<BookProvider>(context);
//     List<Books> searchCategory = providerProvider.searchBookList(query);
//     return GridView.count(
//         childAspectRatio: 0.76,
//         crossAxisCount: 2,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//         children: searchCategory
//             .map((e) => GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (ctx) => DetailScreen(
//                           url: e.url,
//                           title: e.title,
//                           author: e.author,
//                         ),
//                       ),
//                     );
//                   },
//                   child: SingleBook(
//                     url: e.url,
//                     title: e.title,
//                     author: e.author,
//                   ),
//                 ))
//             .toList());
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String title = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                title = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: (title != "" && title != null)
            ? FirebaseFirestore.instance
                .collection('books')
                .where('title', isGreaterThanOrEqualTo: title)
                .snapshots()
            : FirebaseFirestore.instance.collection("books").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data.docs[index];
                    return Card(
                      child: Row(
                        children: <Widget>[
                          Image.network(
                            data['url'],
                            width: 120,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            data['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
