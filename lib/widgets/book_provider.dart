import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:smart_library/models/books.dart';

class BookProvider with ChangeNotifier {
  List<Books> feature = [];
  Books featureData;

  Future<void> getFeatureData() async {
    List<Books> newList = [];
    QuerySnapshot featureSnapShot =
        await FirebaseFirestore.instance.collection("books").get();
    featureSnapShot.docs.forEach(
      (element) {
        featureData = Books(
            url: element.data()["url"],
            title: element.data()["title"],
            author: element.data()["author"]);
        newList.add(featureData);
      },
    );
    feature = newList;
  }

  List<Books> get getFeatureList {
    return feature;
  }

  List<Books> homeFeature = [];

  Future<void> getHomeFeatureData() async {
    List<Books> newList = [];
    QuerySnapshot featureSnapShot =
        await FirebaseFirestore.instance.collection("books").get();
    featureSnapShot.docs.forEach(
      (element) {
        featureData = Books(
            url: element.data()["url"],
            title: element.data()["title"],
            author: element.data()["author"]);
        newList.add(featureData);
      },
    );
    homeFeature = newList;
    notifyListeners();
  }

  List<Books> get getHomeFeatureList {
    return homeFeature;
  }

  List<Books> homeAchive = [];

  Future<void> getHomeAchiveData() async {
    List<Books> newList = [];
    QuerySnapshot featureSnapShot =
        await FirebaseFirestore.instance.collection("books").get();
    featureSnapShot.docs.forEach(
      (element) {
        featureData = Books(
            url: element.data()["url"],
            title: element.data()["title"],
            author: element.data()["author"]);
        newList.add(featureData);
      },
    );
    homeAchive = newList;
    notifyListeners();
  }

  List<Books> get getHomeAchiveList {
    return homeAchive;
  }

  List<Books> newAchives = [];
  Books newAchivesData;
  Future<void> getNewAchiveData() async {
    List<Books> newList = [];
    QuerySnapshot achivesSnapShot =
        await FirebaseFirestore.instance.collection("books").get();
    achivesSnapShot.docs.forEach(
      (element) {
        newAchivesData = Books(
            url: element.data()["url"],
            title: element.data()["title"],
            author: element.data()["author"]);
        newList.add(newAchivesData);
      },
    );
    newAchives = newList;
    notifyListeners();
  }

  List<Books> get getNewAchiesList {
    return newAchives;
  }

  List<String> notificationList = [];

  void addNotification(String notification) {
    notificationList.add(notification);
  }

  int get getNotificationIndex {
    return notificationList.length;
  }

  get getNotificationList {
    return notificationList;
  }

  List<Books> searchList;
  void getSearchList({List<Books> list}) {
    searchList = list;
  }

  List<Books> searchBookList(String query) {
    List<Books> searchBook = searchList.where((element) {
      return element.title.toUpperCase().contains(query) ||
          element.title.toLowerCase().contains(query);
    }).toList();
    return searchBook;
  }
}
