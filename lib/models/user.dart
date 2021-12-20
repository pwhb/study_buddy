class User {
  User({required this.uid, required this.username});
  final String uid;
  final String username;
  String? displayName;
  String? picture;
  String? bio;
  String? interests;
  List<String>? friends;
}