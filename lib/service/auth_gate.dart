import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yazilim_toplulugu_app/main.dart';
import 'package:yazilim_toplulugu_app/pages/register_login_page/register_and_login_page.dart';

class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.idTokenChanges(), // <-- önerilen stream
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasData) {
          return Main_page();
        } else {
          return register_and_login_page();
        }
      },
    );
  }
}
