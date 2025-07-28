import 'package:flutter/material.dart';

AppBar appbar_login_page() {
  return AppBar(
    title: Center(child: Text('giriş ekranı')),
    backgroundColor: Color.fromARGB(197, 1, 178, 237),
  );
}

CircleAvatar profile_avatar_login() {
  return CircleAvatar(
    radius: 60,
    backgroundColor: Colors.blueAccent,
    child: Icon(Icons.person, size: 60, color: Colors.white),
  );
}
