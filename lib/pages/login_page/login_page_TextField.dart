import 'package:flutter/material.dart';

TextField password_box(TextEditingController passwordController) {
  return TextField(
    controller: passwordController,
    decoration: InputDecoration(
      labelText: 'şifre',
      border: OutlineInputBorder(),
    ),
  );
}

TextField email_box(TextEditingController emailController) {
  return TextField(
    controller: emailController,
    decoration: InputDecoration(
      labelText: 'e-mail',
      border: OutlineInputBorder(),
    ),
  );
}
