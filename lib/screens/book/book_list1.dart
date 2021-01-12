import 'package:smart_library/components/card_book.dart';
import 'package:smart_library/models/books.dart';
import 'package:smart_library/screens/book/book_detail.dart';
import 'package:smart_library/services/db_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BookList extends StatefulWidget {
  BookList({this.uid});

  final String uid;

  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DBQuery().bookLevel1(widget.uid),
      builder: (context, snapshot) {
        List<Books> _bookList = snapshot.data;
        if (snapshot.hasError || !snapshot.hasData) {
          return Container(
            color: Colors.white,
            child: SpinKitRing(
              color: Colors.deepPurple,
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.deepPurple[100],
            appBar: AppBar(
              title: Text('Book List Level 1'),
            ),
            body: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.5),
              ),
              itemCount: _bookList.length,
              padding: EdgeInsets.all(5.0),
              itemBuilder: (context, index) {
                return CardBook(
                  title: _bookList[index].title,
                  author: _bookList[index].author,
                  url: _bookList[index].url,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetail(
                          uid: _bookList[index].uid,
                          // userId: widget.userId,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        }
      },
    );
  }
}
