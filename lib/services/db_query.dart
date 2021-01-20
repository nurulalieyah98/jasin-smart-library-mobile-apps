import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_library/models/books.dart';
import 'package:smart_library/models/beacons.dart';

class DBQuery {
  final String uid;
  DBQuery({this.uid});
  //books
  final CollectionReference _booksCollection =
      FirebaseFirestore.instance.collection('books');

  //beacons
  final CollectionReference _beaconsCollection =
      FirebaseFirestore.instance.collection('beacon');

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

  //Get All book level 1 Data
  Future bookLevel1(String uid) async {
    try {
      QuerySnapshot snapshot = await _booksCollection
          .where('beaconName', isEqualTo: 'Level 1')
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

  //Get All book level 2 Data
  Future bookLevel2(String uid) async {
    try {
      QuerySnapshot snapshot = await _booksCollection
          .where('beaconName', isEqualTo: 'Level 2')
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

  //Get All Beacons Data from Snapshot
  Future<List<Beacons>> beaconList(String uid) async {
    try {
      final QuerySnapshot snapshot = await _beaconsCollection.get();

      return snapshot.docs
          .map(
            (e) => Beacons(
                uid: uid,
                beaconId: e.get('beaconId') ?? '',
                major: e.get('major') ?? '',
                minor: e.get('minor') ?? '',
                beaconName: e.get('beaconName') ?? ''),
          )
          .toList();
    } catch (e) {
      print(e.toString());
    }
  }
}
