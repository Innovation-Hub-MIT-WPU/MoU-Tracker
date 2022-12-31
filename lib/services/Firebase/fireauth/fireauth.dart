import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authState {
    return _auth.authStateChanges();
  }

  User? getCurrentUser() {
    User? res = _auth.currentUser;
    return res;
  }

  Future logOut() async {
    try {
      await _auth.signOut();
    } catch (err) {
      print("Error in signing-out : $err");
    }
  }
}
