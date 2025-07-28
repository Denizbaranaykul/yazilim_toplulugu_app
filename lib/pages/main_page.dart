import 'package:flutter/material.dart';
import 'package:yazilim_toplulugu_app/main_page/main_page_body.dart';

class Main_Page extends StatelessWidget {
  const Main_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        container_void_main(), // üst boşluk bırakıyor
        // Üçgen ve butonlar
        Padding(
          padding: const EdgeInsets.only(
            bottom: 40.0,
          ), // üçgeni biraz yukarı çeker
          child: triangle_box_main(),
        ),

        // Etkinlik Kartı
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: card_event_main(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: card_event_main(),
        ),
      ],
    );
  }
}
