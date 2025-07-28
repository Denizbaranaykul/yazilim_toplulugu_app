import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yazilim_toplulugu_app/pages/register_page.dart';
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
      appBar: AppBar(
        title: Center(child: Text('giriş ekranı')),
        backgroundColor: Color.fromARGB(197, 1, 178, 237),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            profile_avatar_login(),
            const SizedBox(height: 24),
            email_box(),
            const SizedBox(height: 16),
            password_box(),
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
          // 🔥 Yönlendirme yok! AuthGate bunu yapacak zaten
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

  TextField password_box() {
    return TextField(
      controller: passwordController,
      decoration: InputDecoration(
        labelText: 'şifre',
        border: OutlineInputBorder(),
      ),
    );
  }

  TextField email_box() {
    return TextField(
      controller: emailController,
      decoration: InputDecoration(
        labelText: 'e-mail',
        border: OutlineInputBorder(),
      ),
    );
  }

  CircleAvatar profile_avatar_login() {
    return CircleAvatar(
      radius: 60,
      backgroundColor: Colors.blueAccent,
      child: Icon(Icons.person, size: 60, color: Colors.white),
    );
  }
}
