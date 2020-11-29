import 'package:flutter/material.dart';
import 'package:smart_library/screens/books/book_page1.dart';

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
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        height: 350.0,
        margin: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: [
            Container(
              height: 350.0,
              width: 250,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  "$image",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.pink[600],
                          height: 110,
                          fontWeight: FontWeight.w900),
                    ),
                    // Text(
                    //   shelves,
                    //   style: Constants.regularHeading,
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
