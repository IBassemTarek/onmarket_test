import 'package:firebase_auth/firebase_auth.dart';

import '../Models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel userFromFirebaseUser(user) {
    return UserModel(id: user.uid);
  }

  Stream<UserModel> get user {
    return _auth.authStateChanges().map(userFromFirebaseUser);
  }

  Future signIn(emailSignIn, passwordSignIn) async {
    var authResult = await _auth.signInWithEmailAndPassword(
        email: emailSignIn, password: passwordSignIn);
    return authResult.user;
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

}
