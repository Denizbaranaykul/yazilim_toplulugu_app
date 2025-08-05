import 'package:flutter/material.dart';

CircleAvatar profile_icon() {
  return CircleAvatar(
    radius: 60,
    backgroundColor: Colors.blueAccent,
    child: Icon(Icons.person, size: 60, color: Colors.white),
  );
}

TextField profile_field(
  String label,
  TextEditingController control, {
  bool obscureText = false,
  bool read = false,
}) {
  return TextField(
    readOnly: read,
    controller: control,
    obscureText: obscureText,
    decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
  );
}
