import 'package:flutter/material.dart';

TextField Text_box(TextEditingController TextController, String label) {
  return TextField(
    controller: TextController,
    decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
  );
}
