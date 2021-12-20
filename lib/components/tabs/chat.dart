import 'package:flutter/material.dart';
import 'package:study_buddy/constants.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Index 3: Chat',
      style: kOptionStyle,
    );
  }
}
