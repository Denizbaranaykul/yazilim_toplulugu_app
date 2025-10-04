import 'package:flutter/material.dart';

BottomNavigationBarItem profile_page_button_bottom() {
  return BottomNavigationBarItem(
    icon: Icon(Icons.person, color: Color.fromARGB(244, 2, 188, 20)),
    label: 'Profil',
  );
}

BottomNavigationBarItem events_page_button_bottom() {
  return BottomNavigationBarItem(
    icon: Icon(Icons.event, color: Color.fromARGB(235, 0, 149, 255)),
    label: 'Etkinlik',
  );
}

BottomNavigationBarItem video_page_button_bottom() {
  return BottomNavigationBarItem(
    icon: Icon(Icons.video_library, color: Color.fromARGB(221, 255, 0, 0)),
    label: 'Videolar',
  );
}

BottomNavigationBarItem main_page_button_bottom() => BottomNavigationBarItem(
  icon: Icon(Icons.home, color: Color.fromARGB(120, 28, 1, 1)),
  label: 'Anasayfa',
);

BottomNavigationBarItem forum_page_button_bottom() => BottomNavigationBarItem(
  icon: Icon(Icons.smart_toy, color: Color.fromARGB(247, 7, 115, 132)),
  label: 'Yapay Zeka',
);

BottomNavigationBarItem game_page_button_bottom() => BottomNavigationBarItem(
  icon: Icon(Icons.sports_esports, color: Color.fromARGB(247, 222, 101, 9)),
  label: 'oyun',
);
