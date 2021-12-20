import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy/screens/welcome_screen.dart';

class LogoutAlertDialog extends StatelessWidget {
  const LogoutAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   AlertDialog(
      title: const Text('Are you sure?'),
      content:
      const Text('You\'re about to logout your account.'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(
                context, WelcomeScreen.id);
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
