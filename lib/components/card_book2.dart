import 'package:flutter/material.dart';

class CardBook extends StatelessWidget {
  CardBook({this.title, this.onTap, this.url, this.synopsis, this.author});

  final String title;
  final Function onTap;
  final String url;
  final String author;
  final String synopsis;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          child: InkWell(
            splashColor: Colors.deepOrangeAccent.withAlpha(30),
            onTap: onTap,
            borderRadius: BorderRadius.circular(30.0),
            child: Container(
              width: 120.0,
              height: 100.0,
              child: Image(
                image: AssetImage(url),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          title,
        ),
      ],
    );
  }
}
