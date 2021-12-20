import 'package:flutter/material.dart';

const String kAppName = 'Study Buddy';

const Color kBackgroundColor = Colors.white;

const Color kThemeColor = Color(0xFF96CFC8);

const InputDecoration kAuthInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(30.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.lightBlue,
      width: 1.0,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(30.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.lightBlue,
      width: 2.0,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(30.0),
    ),
  ),
);

const TextStyle kOptionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

enum HomeMenuChoices {
  about,
  setting,
  logout,
}
