import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yazilim_toplulugu_app/pages/register_page/appbar_register.dart';
import 'package:yazilim_toplulugu_app/pages/register_page/register_page_TextFiled.dart';
import 'package:yazilim_toplulugu_app/service/auth.dart';
import 'package:yazilim_toplulugu_app/service/local_notification.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? erorMessage;
  Future<bool> create_user() async {
    try {
      await Auth().create_user(
        email: emailController.text,
        password: passwordController.text,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      //sadece auth hatalarını yakalar
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
      appBar: appbar_register(),
      body: Column(
        children: [
          const SizedBox(height: 16),
          emailbox(emailController),
          const SizedBox(height: 16),
          password_box(passwordController),
          const SizedBox(height: 16),
          Builder(
            builder: (context) {
              return register_button(context);
            },
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 153, 255, 0),
      ),
    );
  }

  ElevatedButton register_button(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        bool result = await create_user();

        if (result) {
          showSuccessNotification();
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

      child: Text('kayıt ol'),
    );
  }
}
