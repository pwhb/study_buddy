import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:study_buddy/components/rounded_button.dart';
import 'package:study_buddy/components/user_image.dart';
import 'package:study_buddy/screens/home_screen.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({Key? key}) : super(key: key);
  static const String id = 'profile_setup_screen';

  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _profiles =
      FirebaseFirestore.instance.collection('profiles');
  late User _currentUser;
  late dynamic _profile;
  late String _imageUrl;
  bool _showSpinner = false;

  void getCurrentUser() async {
    setState(() {
      _showSpinner = true;
    });
    if (_auth.currentUser != null) {
      _currentUser = _auth.currentUser!;
      await _profiles.doc(_currentUser.uid).get().then((value) => {
            setState(() {
              _profile = value.data();
              _imageUrl = _profile['photoUrl'];
            })
          });
    }
    setState(() {
      _showSpinner = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            UserImage(
              uid: _currentUser.uid,
              imageUrl: _imageUrl,
              onUrlChange: (String newUrl) {
                setState(() {
                  _imageUrl = newUrl;
                });
              },
            ),
            RoundedButton(
                title: 'Done',
                color: Colors.lightBlueAccent,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, HomeScreen.id);
                })
            // UserInfo(),
          ],
        ),
      ),
    );
  }
}
