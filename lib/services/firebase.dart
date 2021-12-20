import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<bool> signIn(String email, String password) async {
  try {
    await auth.signInWithEmailAndPassword(email: email, password: password);

    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> signUp(String email, String password) async {
  try {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    String uid = FirebaseAuth.instance.currentUser!.uid;
    firestore.collection('profiles').doc(uid).set({
      'username': uid,
    });
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future getMyProfile() async {
  try {
    String uid = auth.currentUser!.uid;
    dynamic profile;
    await firestore
        .collection('profiles')
        .doc(uid)
        .get()
        .then((value) => profile = value.data());
    return profile;
  } catch (e) {
    print(e);
    return null;
  }
}

// void getCurrentUser() {
//   if (auth.currentUser != null) {
//     currentUser = _auth.currentUser!;
//   }
// }

// void dummy() {
//   try {
//     auth.currentUser.updateDisplayName('displayName')
//   } catch (e) {
//     print(e)
//   }
// }
