import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/models/app.dart';
import 'package:study_buddy/screens/home_screen.dart';
import 'package:study_buddy/screens/login_screen.dart';
import 'package:study_buddy/screens/profile_setup_screen.dart';
import 'package:study_buddy/screens/registration_screen.dart';
import 'package:study_buddy/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StudyBuddyApp(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => const WelcomeScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          RegistrationScreen.id: (context) => const RegistrationScreen(),
          HomeScreen.id: (context) => const HomeScreen(),
          ProfileSetupScreen.id: (context) => const ProfileSetupScreen(),
        },
      ),
    );
  }
}
