import 'package:flutter/material.dart';
import 'package:yazilim_toplulugu_app/pages/register_login_page/register_and_login_page_TextFiled.dart';
import 'package:yazilim_toplulugu_app/service/auth.dart';
import 'package:yazilim_toplulugu_app/variable/globals.dart' as globals;

class register_and_login_page extends StatefulWidget {
  const register_and_login_page({super.key});

  @override
  State<register_and_login_page> createState() =>
      _register_and_login_pageState();
}

class _register_and_login_pageState extends State<register_and_login_page> {
  String? erorMessage;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: globals.isLogin ? Colors.blue : Colors.orange,
        title: Center(child: Text(globals.isLogin ? 'Giriş Yap' : 'Kayıt Ol')),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          emailbox(emailController),
          const SizedBox(height: 16),
          password_box(passwordController),
          const SizedBox(height: 16),
          action_button(context),
          switch_mode_button(),
        ],
      ),
    );
  }

  ElevatedButton action_button(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          globals.first = true;
          if (globals.isLogin == true) {
            await Auth().signIn(
              email: emailController.text,
              password: passwordController.text,
            );
          } else {
            await Auth().create_user(
              email: emailController.text,
              password: passwordController.text,
            );
          }
        } catch (e) {
          setState(() {
            erorMessage = e.toString();
            print("Giriş hatası: $erorMessage");
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Hata: $erorMessage"),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Text(globals.isLogin ? 'Giriş Yap' : 'Kayıt Ol'),
    );
  }

  ElevatedButton switch_mode_button() {
    String mod = "";
    if (globals.isLogin == true) {
      mod = "kayıt olup giriş yapmak için basınız";
    } else {
      mod = "zaten hesabınız var mı direkt giriş yapmak için tıklayınız";
    }
    return ElevatedButton(
      onPressed: () {
        setState(() {
          globals.isLogin = !globals.isLogin; // login <-> kayıt geçişi
        });
      },
      child: Text(mod),
    );
  }
}
