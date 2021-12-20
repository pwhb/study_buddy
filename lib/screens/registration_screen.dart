import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:study_buddy/components/rounded_button.dart';
import 'package:study_buddy/constants.dart';
import 'package:study_buddy/screens/login_screen.dart';
import 'package:study_buddy/screens/profile_setup_screen.dart';
import 'package:study_buddy/services/firebase.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _showSpinner = false;
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Create your account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _emailField,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                decoration:
                    kAuthInputDecoration.copyWith(hintText: 'Enter your email'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _passwordField,
                obscureText: !_showPassword,
                textAlign: TextAlign.center,
                decoration: kAuthInputDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                      value: _showPassword,
                      onChanged: (bool? value) {
                        setState(() {
                          _showPassword = value!;
                        });
                      }),
                  const Text('Show Password')
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              RoundedButton(
                title: 'Sign Up',
                color: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    _showSpinner = true;
                  });
                  bool success =
                      await signUp(_emailField.text, _passwordField.text);
                  setState(() {
                    _showSpinner = false;
                  });
                  if (success) {
                    Navigator.pushReplacementNamed(context, ProfileSetupScreen.id);
                  }
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, LoginScreen.id);
                  },
                  child: const Text('Already have an account? Sign In.'))
            ],
          ),
        ),
      ),
    );
  }
}
