import 'package:flutter/material.dart';

// const textInputDecoration = InputDecoration(
//   fillColor: Colors.white,
//   filled: true,
//   enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: Colors.white, width: 2.0)),
//   focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: Colors.pink, width: 2.0)),
// );

const textInputDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pinkAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
