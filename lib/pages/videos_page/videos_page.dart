import 'package:flutter/material.dart';
import 'package:yazilim_toplulugu_app/pages/videos_page/appbar_video_page.dart';
import 'package:yazilim_toplulugu_app/pages/videos_page/videos_page_play_card.dart';

class video_page extends StatelessWidget {
  const video_page({super.key});
  @override
  Widget build(BuildContext context) {
    final String description = "Flutter ile Video Kartı";
    final String youtubeLink = "https://www.youtube.com/watch?v=dQw4w9WgXcQ";

    return Scaffold(
      appBar: appbar_video_page(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            play_card(description, youtubeLink),
            play_card(description, youtubeLink),
            play_card(description, youtubeLink),
            play_card(description, youtubeLink),
            play_card(description, youtubeLink),
            play_card(description, youtubeLink),
            play_card(description, youtubeLink),
            play_card(description, youtubeLink),
            play_card(description, youtubeLink),
          ],
        ),
      ),
    );
  }
}
