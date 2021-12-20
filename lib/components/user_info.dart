import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy/components/rounded_button.dart';
import 'package:study_buddy/constants.dart';
import 'package:study_buddy/screens/home_screen.dart';
import 'package:study_buddy/services/firebase.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  bool _editUsername = false;
  final TextEditingController _usernameField = TextEditingController();
  late dynamic _profile;
  late String _username;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _profiles =
  FirebaseFirestore.instance.collection('profiles');


  void initFunction() async {
    if (_auth.currentUser != null) {
      dynamic profile = await getMyProfile();
      setState(() {
        _profile = profile;
        _username = _profile['username'];
        _usernameField.value = TextEditingValue(text: _username);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Username'),
              Flexible(
                child: _editUsername
                    ? TextField(
                  controller: _usernameField,
                  textAlign: TextAlign.center,
                  decoration: kAuthInputDecoration,
                )
                    : Text(_username),
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      if (_editUsername) {
                        _username = _usernameField.text;
                      }
                      _editUsername = !_editUsername;
                    });
                  },
                  child: Text(_editUsername ? 'Save' : 'Edit'))
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          RoundedButton(
              title: 'Done',
              color: Colors.lightBlueAccent,
              onPressed: () {
                _profiles
                    .doc(_auth.currentUser!.uid)
                    .update({'username': _username});
                Navigator.pushReplacementNamed(context, HomeScreen.id);
              })
        ],
      ),
    );
  }
}
