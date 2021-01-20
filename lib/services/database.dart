import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_library/models/users.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

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

  //get user doc stream (user document)
  Stream<Users> get userData {
    return usersCollection.doc(uid).snapshots().map(_usersDataFromSnapshot);
  }
}
