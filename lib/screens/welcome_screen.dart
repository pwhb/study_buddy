import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:study_buddy/components/rounded_button.dart';
import 'package:study_buddy/constants.dart';
import 'package:study_buddy/screens/login_screen.dart';
import 'package:study_buddy/screens/registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // late User _user;
  void initializeUser() async {
    // await Firebase.initializeApp();
    final User? firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      print(firebaseUser);
    }
  }

  @override
  void initState() {
    super.initState();
    initializeUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kThemeColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SvgPicture.asset(
              'images/main.svg',
              height: 200.0,
              width: 200.0,
            ),
            // const Text(
            //   kAppName,
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontWeight: FontWeight.bold,
            //     fontSize: 30.0,
            //   ),
            // ),
            const SizedBox(
              height: 30.0,
            ),
            RoundedButton(
              title: 'Login',
              color: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushReplacementNamed(context, LoginScreen.id);
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            RoundedButton(
              title: 'Sign Up',
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.pushReplacementNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
