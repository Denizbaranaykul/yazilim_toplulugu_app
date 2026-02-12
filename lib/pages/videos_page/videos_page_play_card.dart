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

/// YouTube linkinden video ID çıkarır, yoksa null döner
String? _extractYouTubeVideoId(String url) {
  final uri = Uri.tryParse(url);
  if (uri == null) return null;
  final v = uri.queryParameters['v'];
  if (v != null && v.isNotEmpty) return v;
  // youtu.be/VIDEO_ID formatı
  if (uri.host.contains('youtu.be') && uri.pathSegments.isNotEmpty) {
    return uri.pathSegments.first;
  }
  return null;
}

Card play_card(String description, String youtubeLink, {String? imageUrl}) {
  // imageUrl verilmediyse YouTube linkinden thumbnail al
  final vid = _extractYouTubeVideoId(youtubeLink);
  final effectiveImageUrl = imageUrl ??
      (vid != null
          ? 'https://img.youtube.com/vi/$vid/mqdefault.jpg'
          : null);

  return Card(
    color: Color.fromARGB(93, 245, 245, 245),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 4,
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    clipBehavior: Clip.antiAlias,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (effectiveImageUrl != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                effectiveImageUrl,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
            const SizedBox(height: 12),
          ],
          Text(
            description,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () => _launchYouTube(youtubeLink),
              child: const Text("İzle"),
            ),
          ),
        ],
      ),
    ),
  );
}
