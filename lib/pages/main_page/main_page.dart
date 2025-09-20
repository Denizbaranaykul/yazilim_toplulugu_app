import 'package:flutter/material.dart';
import 'package:yazilim_toplulugu_app/pages/events_page/events_card.dart';

class Main_Page extends StatelessWidget {
  const Main_Page({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: screenHeight * 0.05)),
        Expanded(
          flex: 4, // ekranın 4/10'unu kaplar
          child: Center(
            child: Image.asset(
              'assets/icon/app_icon.jpeg',
              width: 300,
              height: 370,
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.06),
                child: event_card(
                  "event_1",
                  "Mikro Çip konferansı\n4 ağustos - saat 11:00",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.02),
                child: event_card(
                  "event_2",
                  "Mikro Çip konferansı\n4 ağustos - saat 11:00",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

ParticipationCard event_card(String event_id, String txt) {
  return ParticipationCard(eventId: event_id, text: txt);
}
