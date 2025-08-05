import 'package:flutter/material.dart';

Row profile_buttons(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [change_button(context)],
  );
}

ElevatedButton change_button(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
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
