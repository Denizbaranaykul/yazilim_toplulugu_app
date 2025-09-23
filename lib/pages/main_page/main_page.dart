import 'package:flutter/material.dart';
import 'package:yazilim_toplulugu_app/pages/events_page/events_card.dart';
import 'package:yazilim_toplulugu_app/variable/globals.dart';

class Main_Page extends StatefulWidget {
  const Main_Page({super.key});

  @override
  State<Main_Page> createState() => _Main_PageState();
}

class _Main_PageState extends State<Main_Page> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: screenHeight * 0.05)),
        Expanded(
          flex: 4, // ekranın 4/10'unu kaplar
          child: AnimatedOpacity(
            duration: Duration(seconds: 5),
            curve: Curves.easeInOut,
            opacity: opacity_main_logo,//GLOBAL DEĞİŞKENDEN ALIYOR
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
                padding: EdgeInsets.only(top: screenHeight * 0.02),
                child: event_card(
                  "event_1",
                  "Yapay zeka kursu\n4 ağustos - saat 11:00",
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
