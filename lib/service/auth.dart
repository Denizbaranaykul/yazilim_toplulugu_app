import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser; //getter setter

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  //register
  Future<void> create_user({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
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
}
