import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_library/models/users.dart';
import 'package:smart_library/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  Future updateUserData(String id, String name, String phone) async {
    return await userCollection.document(uid).setData({
      'id': id,
      'name': name,
      'phone': phone,
    });
  }

  //user list from snapshot
  List<Users> _usersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Users(
        name: doc.data['name'] ?? '',
        id: doc.data['id'] ?? '',
        phone: doc.data['phone'] ?? '0',
      );
    }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      id: snapshot.data['id'],
      name: snapshot.data['name'],
      phone: snapshot.data['phone'],
    );
  }

  //get user stream
  Stream<List<Users>> get users {
    return userCollection.snapshots().map(_usersListFromSnapshot);
  }

  //get user doc stream (user document)
  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
