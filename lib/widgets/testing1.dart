import 'package:flutter/material.dart';
import 'package:smart_library/screens/books/book_page1.dart';
import 'package:transparent_image/transparent_image.dart';

class BookCard1 extends StatelessWidget {
  final String bookID;
  final Function onPressed;
  final String image;
  final String title;
  final String shelves;
  final String author;
  final String category;
  final String synopsis;
  BookCard1(
      {this.onPressed,
      this.image,
      this.title,
      this.bookID,
      this.shelves,
      this.author,
      this.category,
      this.synopsis});

  @override
  Widget build(BuildContext context) {
    // double width, height;
    // width = MediaQuery.of(context).size.width;
    // height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookPage1(
                bookID: bookID,
              ),
            ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 24.0,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300],
                  offset: Offset(-2, -1),
                  blurRadius: 5),
            ]),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: <Widget>[
                    // Positioned.fill(
                    //     child: Align(
                    //   alignment: Alignment.center,
                    //   //child: Loading(),
                    // )),

                    Center(
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: image,
                        fit: BoxFit.fill,
                        height: 140,
                        width: 120,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   width: 6,
            // ),
            // RichText(
            //   textAlign: TextAlign.justify,
            //   text: TextSpan(children: [
            //     TextSpan(
            //       text: '${title.toString()} \n\n',
            //       style: TextStyle(fontSize: 15),
            //     ),
            //     TextSpan(
            //       text: 'by: ${author.toString()} \n\n',
            //       style: TextStyle(fontSize: 15, color: Colors.grey),
            //     ),
            //     TextSpan(
            //       text: 'Synopsis : ${synopsis.toString()} \t\n',
            //       style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            //     ),

            //     // TextSpan(
            //     //   text: product.sale ? 'ON SALE ' : "",

            //     //   style: TextStyle(
            //     //       fontSize: 18,
            //     //       fontWeight: FontWeight.w400,
            //     //       color: Colors.red),
            //     // ),
            //   ], style: TextStyle(color: Colors.black)),
            // ),

            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 10.0,
              ),
              child: Text(
                "Title : ${title.toString()}",
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 10.0,
              ),
              child: Text(
                "Author : ${author.toString()}",
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 10.0,
              ),
              child: Text(
                "Synopsis: ${synopsis.toString()}",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
