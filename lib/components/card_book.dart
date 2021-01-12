import 'package:flutter/material.dart';

class CardBook extends StatelessWidget {
  CardBook({this.url, this.onTap, this.title, this.author, this.synopsis});

  final String url;
  final Function onTap;
  final String title;
  final String author;
  final String synopsis;

  @override
  Widget build(BuildContext context) {
    return Card(
      //margin: EdgeInsets.only(bottom: 15.0),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        splashColor: Colors.deepOrangeAccent.withAlpha(30),
        onTap: onTap,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10.0), //distance between image and border
              Container(
                child: Image(
                  image: NetworkImage(url),
                  width: 150.0,
                  height: 130.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(13.0, 12.0, 13.0, 8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      author,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.pink, fontSize: 12.0),
                    ),
                    // SizedBox(height: 10.0),
                    // Text('Synopsis ' + synopsis),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
