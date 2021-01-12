import 'package:smart_library/models/books.dart';
import 'package:smart_library/services/db_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BookDetail extends StatefulWidget {
  BookDetail({this.uid});

  final String uid;

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  DBQuery _firebaseServices = DBQuery();
  //int _productQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseServices.bookDetail(widget.uid),
      builder: (context, snapshot) {
        Books _bookDetail = snapshot.data;
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
              title: Text('Book Details'),
            ),
            body: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 25.0,
                    ),
                    Center(
                      child: Container(
                        height: 250.0,
                        width: 250.0,
                        child: Image(
                          image: NetworkImage(_bookDetail.url),
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width / 20,
                              left: MediaQuery.of(context).size.width / 20,
                              right: MediaQuery.of(context).size.width / 20,
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                _bookDetail.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 19.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 20,
                              right: MediaQuery.of(context).size.width / 20,
                              top: MediaQuery.of(context).size.height / 50,
                            ),
                            child: Text(
                              'Author : ' + _bookDetail.author.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 20,
                              right: MediaQuery.of(context).size.width / 20,
                              top: MediaQuery.of(context).size.height / 50,
                            ),
                            child: Text(
                              'Category : ' + _bookDetail.category.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 20,
                                right: MediaQuery.of(context).size.width / 20,
                                top: MediaQuery.of(context).size.height / 50,
                              ),
                              child: Text(
                                'Shelves : ' + _bookDetail.shelves.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.0,
                                ),
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 20,
                                right: MediaQuery.of(context).size.width / 20,
                                top: MediaQuery.of(context).size.height / 50,
                              ),
                              child: Text(
                                'Synopsis : ' + _bookDetail.synopsis.toString(),
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.0,
                                ),
                              )),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
