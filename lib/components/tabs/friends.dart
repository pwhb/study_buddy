import 'package:flutter/material.dart';
import 'package:study_buddy/constants.dart';

class Friends extends StatefulWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  @override
  Widget build(BuildContext context) {
    return  const Text(
      'Index 2: Friends',
      style: kOptionStyle,
    );
  }
}
