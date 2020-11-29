import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_library/models/books.dart';
import 'package:smart_library/models/beacons.dart';
import 'package:smart_library/screens/book/book_detail.dart';

class DBQuery {
  final String uid;
  DBQuery({this.uid});
  //books
  final CollectionReference _booksCollection =
      FirebaseFirestore.instance.collection('books');

  //beacons
  final CollectionReference _beaconsCollection =
      FirebaseFirestore.instance.collection('beacon');

  //Get All Books Data from Snapshot
  Future<List<Books>> booksList(String id) async {
    try {
      final QuerySnapshot snapshot = await _booksCollection.get();

      return snapshot.docs
          .map(
            (e) => Books(
              uid: e.id,
              title: e.get('title') ?? '',
              author: e.get('author') ?? '',
              category: e.get('category') ?? '',
              synopsis: e.get('synopsis') ?? '',
              url: e.get('url') ?? '',
              shelves: e.get('shelves') ?? '',
            ),
          )
          .toList();
    } catch (e) {
      print(e.toString());
    }
  }

  //Get One Book Data from Snapshot
  Future bookDetail(uid) async {
    try {
      final DocumentSnapshot snapshot = await _booksCollection.doc(uid).get();
      return Books(
        uid: uid,
        title: snapshot.get('title') ?? '',
        author: snapshot.get('author') ?? '',
        category: snapshot.get('category') ?? '',
        shelves: snapshot.get('shelves') ?? '',
        url: snapshot.get('url') ?? '',
        synopsis: snapshot.get('synopsis') ?? '',
      );
    } catch (e) {
      print(e.toString());
    }
  }

  //Get Ingredients Data
  Future bookLevel1(String uid) async {
    try {
      QuerySnapshot snapshot = await _booksCollection
          .where('beaconId', isEqualTo: 'b9407f30-f5f8-466e-aff9-25556b57fe6a')
          .get();

      return snapshot.docs
          .map(
            (e) => Books(
              uid: e.id,
              title: e.get('title') ?? '',
              author: e.get('author') ?? '',
              category: e.get('category') ?? '',
              synopsis: e.get('synopsis') ?? '',
              url: e.get('url') ?? '',
              shelves: e.get('shelves') ?? '',
            ),
          )
          .toList();
    } catch (e) {
      print(e.toString());
    }
  }

  Future bookLevel2(String uid) async {
    try {
      QuerySnapshot snapshot = await _booksCollection
          .where('beaconId', isEqualTo: 'b9407f30-f5f8-466e-aff9-25556b57fe6b')
          .get();

      return snapshot.docs
          .map(
            (e) => Books(
              uid: e.id,
              title: e.get('title') ?? '',
              author: e.get('author') ?? '',
              category: e.get('category') ?? '',
              synopsis: e.get('synopsis') ?? '',
              url: e.get('url') ?? '',
              shelves: e.get('shelves') ?? '',
            ),
          )
          .toList();
    } catch (e) {
      print(e.toString());
    }
  }
}
