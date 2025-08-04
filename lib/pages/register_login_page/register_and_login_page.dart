import 'package:flutter/material.dart';
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

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  UserService userService = UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: globals.isLogin ? Colors.blue : Colors.orange,
        title: Center(child: Text(globals.isLogin ? 'Giriş Yap' : 'Kayıt Ol')),
      ),
      body: Column(
        children: globals.isLogin
            ? [
                const SizedBox(height: 16),
                Text_box(emailController, "e-mail"),
                const SizedBox(height: 16),
                Text_box(passwordController, "şifre"),
                const SizedBox(height: 16),
                action_button(context),
                switch_mode_button(),
              ]
            : [
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
