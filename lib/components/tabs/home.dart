import 'package:flutter/material.dart';
import 'package:study_buddy/constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Index 1: Home',
      style: kOptionStyle,
    );
  }
}
