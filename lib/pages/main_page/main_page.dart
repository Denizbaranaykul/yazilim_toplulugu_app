import 'package:flutter/material.dart';
import 'package:yazilim_toplulugu_app/pages/events_page/events_card.dart';

class Main_Page extends StatelessWidget {
  const Main_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // container_void_main(), // üst boşluk bırakıyor
        // Üçgen ve butonlar
        Center(
          child: Image.asset(
            'assets/icon/app_icon.jpeg',
            width: 300,
            height: 450,
          ),
        ),

        event_card("event_1", "Mikro Çip konferansı\n4 ağustos - saat 11:00"),
        event_card("event_2", "Mikro Çip konferansı\n4 ağustos - saat 11:00"),
      ],
    );
  }
}

ParticipationCard event_card(String event_id, String txt) {
  return ParticipationCard(eventId: event_id, text: txt);
}
