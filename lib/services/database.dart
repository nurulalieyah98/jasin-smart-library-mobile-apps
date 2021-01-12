import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_library/models/users.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference booksCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference booksRef = FirebaseFirestore.instance
      .collection('beacons')
      .doc('b9407f30-f5f8-466e-aff9-25556b57fe6a')
      .collection('level 1');

  final CollectionReference booksRef2 = FirebaseFirestore.instance
      .collection('beacons')
      .doc('b9407f30-f5f8-466e-aff9-25556b57fe6b')
      .collection('level 2');

  Future updateUserData(String id, String name, String phone) async {
    return await usersCollection.doc(uid).set({
      'id': id,
      'name': name,
      'phone': phone,
    });
  }

  //create user info
  Future userInfo(String email, String id, String name, String phone) async {
    return await usersCollection.doc(uid).set({
      'email': email,
      'id': id,
      'name': name,
      'phone': phone,
    });
  }

  // Future deleteuser() {
  //   return usersCollection.doc(uid).delete();
  // }

  // //user list from snapshot
  // List<Users> _usersListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.documents.map((doc) {
  //     return Users(
  //       uid: uid,
  //       name: doc.get('name') ?? '',
  //       id: doc.get('id') ?? '',
  //       phone: doc.get('phone') ?? '',
  //     );
  //   }).toList();
  // }

  //userData from snapshot
  Users _usersDataFromSnapshot(DocumentSnapshot snapshot) {
    return Users(
      uid: uid,
      email: snapshot.get('email') ?? '',
      name: snapshot.get('name') ?? '',
      id: snapshot.get('id') ?? '',
      phone: snapshot.get('phone') ?? '',
    );
  }

  // //get user stream
  // Stream<List<Users>> get users {
  //   return userCollection.snapshots().map(_usersListFromSnapshot);
  // }

  //get user doc stream (user document)
  Stream<Users> get userData {
    return usersCollection.doc(uid).snapshots().map(_usersDataFromSnapshot);
  }
}
