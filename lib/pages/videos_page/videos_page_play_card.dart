import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void _launchYouTube(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Link açılamadı: $url';
  }
}

Card play_card(String description, String youtubeLink) {
  return Card(
    color: Color.fromARGB(93, 245, 245, 245),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 4,
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () => _launchYouTube(youtubeLink),
              child: Text("İzle"),
            ),
          ),
        ],
      ),
    ),
  );
}
