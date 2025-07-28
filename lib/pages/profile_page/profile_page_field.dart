import 'package:flutter/material.dart';

CircleAvatar profile_icon() {
  return CircleAvatar(
    radius: 60,
    backgroundColor: Colors.blueAccent,
    child: Icon(Icons.person, size: 60, color: Colors.white),
  );
}

TextField email_field() {
  return TextField(
    readOnly: true,
    decoration: InputDecoration(
      labelText: "İsim",
      border: OutlineInputBorder(),
    ),
  );
}

TextField password_field() {
  return TextField(
    readOnly: true,
    obscureText: true,
    decoration: InputDecoration(
      labelText: "Şifre",
      border: OutlineInputBorder(),
    ),
  );
}
