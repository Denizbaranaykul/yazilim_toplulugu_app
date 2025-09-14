import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser; //getter setter

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  //register
  Future<UserCredential> create_user({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  //login
  Future<void> signIn({required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  //sign out
  Future<void> signOut({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signOut();
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print("Şifre sıfırlama maili gönderildi: $email");
    } catch (e) {
      print("Hata: $e");
    }
  }
}
