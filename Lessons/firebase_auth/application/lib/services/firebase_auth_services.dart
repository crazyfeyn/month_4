import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {
  Future<bool> signIn(String newEmail, String newPassword) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: newEmail, password: newPassword);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> signUp(String newEmail, String newPassword) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: newEmail, password: newPassword);
  }
}
