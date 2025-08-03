import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yazilim_toplulugu_app/pages/register_page/register_page_TextFiled.dart';
import 'package:yazilim_toplulugu_app/service/auth.dart';

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

  // 👇 login/kayıt modunu tutan değişken
  bool isLogin = true;

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

  Future<bool> create_user() async {
    try {
      await Auth().create_user(
        email: emailController.text,
        password: passwordController.text,
      );
      await FirebaseAuth.instance.signOut();
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
  Widget build(BuildContext context) {
    return Scaffold(
      // 👇 AppBar rengi ve yazısı mod'a göre değişiyor
      appBar: AppBar(
        backgroundColor: isLogin ? Colors.blue : Colors.orange,
        title: Center(child: Text(isLogin ? 'Giriş Yap' : 'Kayıt Ol')),
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

  // 👇 Giriş veya kayıt işlemini tetikler
  ElevatedButton action_button(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        bool result = isLogin ? await signIn() : await create_user();

        if (result) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                isLogin
                    ? "Başarı ile giriş yapıldı"
                    : "Kayıt başarılı, şimdi giriş yapın",
              ),
              duration: Duration(seconds: 2),
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
      child: Text(isLogin ? 'Giriş Yap' : 'Kayıt Ol'),
    );
  }

  ElevatedButton switch_mode_button() {
    String mod = "";
    if (isLogin == true) {
      mod = "kayıt olup giriş yapmak için basınız";
    } else {
      mod = "zaten hesabınız var mı direkt giriş yapmak için tıklayınız";
    }
    return ElevatedButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin; // login <-> kayıt geçişi
        });
      },
      child: Text(mod),
    );
  }
}
