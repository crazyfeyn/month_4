import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseController {
  final authFirebaseController = AuthFirebaseController();
  Future<bool> login(String newEmail, String newPassword) async {
    return authFirebaseController.login(newEmail, newPassword);
  }

  Future<void> signUp(String newEmail, String newPassword) async {
    authFirebaseController.signUp(newEmail, newPassword);
  }
}
