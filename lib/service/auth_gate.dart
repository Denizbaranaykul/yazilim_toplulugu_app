import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yazilim_toplulugu_app/main.dart';
import 'package:yazilim_toplulugu_app/pages/register_login_page/register_and_login_page.dart';
import 'package:yazilim_toplulugu_app/service/notification_question.dart';
import 'package:yazilim_toplulugu_app/variable/globals.dart' as globals;

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
          if (globals.isLogin && globals.first) {
            NotificationHelper.showNotification(
              title: "Hoşgeldiniz",
              body:
                  "başarı ile giriş yapıldı çıkış yapana kadar oturumunuz açık kalacaktır ",
            );
          } else if (globals.isLogin == false && globals.first) {
            NotificationHelper.showNotification(
              title: "Hoşgeldiniz",
              body:
                  "başarı ile kaydınız yapıldı bir sonra ki girişinizde e-mail ve şifreiniz ile giriş yapabilirsiniz ",
            );
          }

          return Main_page();
        } else {
          return register_and_login_page();
        }
      },
    );
  }
}
