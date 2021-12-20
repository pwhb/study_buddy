import 'package:flutter/material.dart';
import 'package:study_buddy/components/tabs/chat.dart';
import 'package:study_buddy/components/alert_dialogs/exit_alert_dialog.dart';
import 'package:study_buddy/components/tabs/friends.dart';
import 'package:study_buddy/components/tabs/home.dart';
import 'package:study_buddy/components/alert_dialogs/logout_alert_dialog.dart';
import 'package:study_buddy/components/tabs/profile.dart';
import 'package:study_buddy/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const Profile(),
    const Home(),
    const Friends(),
    const Chat(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
            context: context, builder: (context) => const ExitAlertDialog()) ??
        false);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Study Buddy'),
          centerTitle: true,
          backgroundColor: Colors.lightBlueAccent,
          actions: [
            PopupMenuButton(
                onSelected: (value) {
                  if (value == HomeMenuChoices.logout) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          const LogoutAlertDialog(),
                    );
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuItem>[
                      const PopupMenuItem(
                        child: Text('About'),
                        value: HomeMenuChoices.about,
                      ),
                      const PopupMenuItem(
                        child: Text('Setting'),
                        value: HomeMenuChoices.setting,
                      ),
                      const PopupMenuItem(
                          child: Text('Log out'),
                          value: HomeMenuChoices.logout),
                    ])
          ],
        ),
        body: Center(
          child: _widgetOptions[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Friends',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.question_answer),
              label: 'Chat',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.lightBlueAccent,
          unselectedItemColor: Colors.blueGrey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
