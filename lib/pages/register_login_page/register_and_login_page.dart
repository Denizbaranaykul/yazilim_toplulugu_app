import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yazilim_toplulugu_app/models/user_model.dart';
import 'package:yazilim_toplulugu_app/pages/register_login_page/register_and_login_page_TextFiled.dart';
import 'package:yazilim_toplulugu_app/service/auth.dart';
import 'package:yazilim_toplulugu_app/service/user_service.dart';
import 'package:yazilim_toplulugu_app/variable/globals.dart' as globals;

class register_and_login_page extends StatefulWidget {
  const register_and_login_page({super.key});

  @override
  State<register_and_login_page> createState() =>
      _register_and_login_pageState();
}

class _register_and_login_pageState extends State<register_and_login_page> {
  String? erorMessage;

  final String url =
      "https://www.google.com/search?gs_ssp=eJzj4tLP1TcoSzLJKctRYDRgdGDw4ijPSCwpTiwoAABiYAe2&q=whatsapp&oq=&gs_lcrp=EgZjaHJvbWUqDwgAEC4YJxjHARjqAhjRAzIPCAAQLhgnGMcBGOoCGNEDMgkIARAjGCcY6gIyCQgCECMYJxjqAjIJCAMQIxgnGOoCMgkIBBAjGCcY6gIyCQgFEC4YJxjqAjIJCAYQIxgnGOoCMg8IBxAuGCcYxwEY6gIY0QPSAQszOTAxMDgyajBqN6gCCLACAfEFXq4WRHmAmA_xBV6uFkR5gJgP&sourceid=chrome&ie=UTF-8";
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  UserService userService = UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: globals.isLogin
            ? const Color.fromARGB(255, 35, 129, 229)
            : const Color.fromARGB(255, 83, 103, 148),
        title: Center(child: Text(globals.isLogin ? 'Giriş Yap' : 'Kayıt Ol')),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20, // alt boşluk
            left: 16,
            right: 16,
            top: 16,
          ),
          child: IntrinsicHeight(
            // Column yüksekliklerini düzgün hesaplar
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: globals.isLogin
                  ? [
                      logo(300, 370),
                      const SizedBox(height: 16),
                      Text_box(emailController, "e-mail"),
                      const SizedBox(height: 16),
                      Text_box(passwordController, "şifre"),
                      const SizedBox(height: 16),
                      action_button(context),
                      forgot_password_button(context),
                      switch_mode_button(),
                    ]
                  : [
                      logo(250, 270),
                      const SizedBox(height: 16),
                      Text_box(nameController, "isim"),
                      const SizedBox(height: 16),
                      Text_box(surnameController, "soy isim"),
                      const SizedBox(height: 16),
                      Text_box(emailController, "e-mail"),
                      const SizedBox(height: 16),
                      Text_box(passwordController, "şifre"),
                      const SizedBox(height: 16),
                      action_button(context),
                      univercity_button(url),
                      switch_mode_button(),
                    ],
            ),
          ),
        ),
      ),
    );
  }

  Center logo(double x, double y) {
    return Center(
      child: Image.asset('assets/icon/app_icon.jpeg', width: x, height: y),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception("Link açılamadı: $url");
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Şifre sıfırlama maili gönderildi: $email"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hata: $e"), backgroundColor: Colors.red),
      );
    }
  }

  ElevatedButton forgot_password_button(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final email = emailController.text.trim();
        if (email.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Lütfen e-posta adresinizi girin")),
          );
        } else {
          resetPassword(email);
        }
      },
      child: const Text("Şifremi Unuttum"),
    );
  }

  ElevatedButton univercity_button(String url) => ElevatedButton(
    onPressed: () => _launchUrl(url),
    child: const Text("Topluluğa üniversitemizden kayıt olun"),
  );

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
            final userCred = await Auth().create_user(
              email: emailController.text,
              password: passwordController.text,
            );
            UserModel newUser = UserModel(
              uid: userCred.user!.uid,
              name: nameController.text,
              surname: surnameController.text,
              email: emailController.text,
            );

            userService.createUserDataBase(newUser);
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
          globals.isLogin = !globals.isLogin;
        });
      },
      child: Text(mod),
    );
  }
}
