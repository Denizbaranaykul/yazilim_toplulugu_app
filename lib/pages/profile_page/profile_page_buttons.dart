import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yazilim_toplulugu_app/pages/login_page/login_page.dart';

Row profile_buttons(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [change_button(context), sign_out_button(context)],
  );
}

ElevatedButton change_button(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      // Kullanıcıya bilgi ver
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Bilgiler başarıyla güncellendi."),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    },
    child: Text("Değiştir"),
    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
  );
}

ElevatedButton sign_out_button(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(245, 255, 0, 0),
    ),
    onPressed: () async {
      await FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login_page()),
        (route) => false,
      );
    },
    child: Text("Çıkış yap"),
  );
}
