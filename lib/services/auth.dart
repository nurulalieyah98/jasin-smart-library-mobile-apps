import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_library/models/users.dart';
import 'package:smart_library/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase user
  Users _userFromFirebase(User user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<Users> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  //get user id
  String getUserId() {
    return _auth.currentUser.uid;
  }

  //sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email & password
  Future registerUserInfo(String email, String password, String id, String name,
      String phone) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      User user = result.user;
      await DatabaseService(uid: user.uid)
          .userInfo(user.email, id, name, phone);
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
      //print("Successfully Logout");
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //reset password
  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
