import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy/components/tabs/user_info_item.dart';
import 'package:study_buddy/components/user_image.dart';

enum UserInfoType { username, other }

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _showSpinner = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _profiles =
      FirebaseFirestore.instance.collection('profiles');
  late User _currentUser;
  late dynamic _profile;
  late String _imageUrl;
  UserInfoType? _editItem;

  TextEditingController usernameController = TextEditingController();

  void onPressed(UserInfoType type) async {
    if (type == _editItem) {
      _profiles
          .doc(_currentUser.uid)
          .update({'username': usernameController.text});
      await _profiles.doc(_currentUser.uid).get().then((value) => {
            setState(() {
              _profile = value.data();

              usernameController.value =
                  TextEditingValue(text: _profile['username']);
              _editItem = UserInfoType.other;
            })
          });
    } else {
      setState(() {
        _editItem = type;
      });
    }
  }

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
              usernameController.value =
                  TextEditingValue(text: _profile['username']);
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
    return _showSpinner
        ? const Text('loading')
        : ListView(
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
              UserInfoItem(
                edit: _editItem == UserInfoType.username,
                controller: usernameController,
                onPressed: () => onPressed(UserInfoType.username),
              ),
              // Text('Profile ${_profiles.doc(_currentUser.uid)}'),
              GetUserName(_currentUser.uid),
              Text(_profile['username']),
            ],
          );
  }
}

class GetUserName extends StatelessWidget {
  final String documentId;

  const GetUserName(this.documentId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('profiles');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(data['username']);
        }

        return const Text("loading");
      },
    );
  }
}
