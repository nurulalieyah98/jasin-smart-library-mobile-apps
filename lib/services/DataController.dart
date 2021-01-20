import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

//datacontroller for search
class DataController extends GetxController {
  Future getData(String collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await firebaseFirestore.collection(collection).get();
    return snapshot.docs;
  }

  Future queryData(String queryString) async {
    return FirebaseFirestore.instance
        .collection('books')
        .orderBy('title')
        .where('title', isGreaterThanOrEqualTo: queryString)
        .where('title', isLessThanOrEqualTo: queryString + '\uf8ff')
        .get();
  }
}
