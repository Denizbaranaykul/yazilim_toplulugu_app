import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yazilim_toplulugu_app/pages/login_page/appbar_login_page.dart';
import 'package:yazilim_toplulugu_app/pages/login_page/login_page_TextField.dart';
import 'package:yazilim_toplulugu_app/pages/register_page/register_page.dart';
import 'package:yazilim_toplulugu_app/service/auth.dart';

class Login_page extends StatefulWidget {
  const Login_page({super.key});

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  String? erorMessage;
  Future<bool> signIn() async {
    try {
      await Auth().signIn(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      setState(() {
        erorMessage = e.message;
      });
      return false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar_login_page(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            profile_avatar_login(),
            const SizedBox(height: 24),
            email_box(emailController),
            const SizedBox(height: 16),
            password_box(passwordController),
            const SizedBox(height: 16),
            sign_in_button(context),
            const SizedBox(height: 16),
            register_button(context),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(222, 0, 140, 255),
      ),
    );
  }

  ElevatedButton register_button(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterPage()),
        );
      },
      child: Text('kayıt ol'),
    );
  }

  ElevatedButton sign_in_button(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        bool result = await signIn();

        if (result) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Başarı ile giriş yapıldı"),
              duration: Duration(seconds: 1),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Hata: $erorMessage"),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Text('giriş yap'),
    );
  }
}
