import 'package:flutter/material.dart';

Card card_event_main() {
  return Card(
    color: const Color.fromARGB(237, 210, 3, 79),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Etkinlik: Yapay Zeka Sunumu\n21 Temmuz - Saat 21:00',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          main_page_katilim_button(),
        ],
      ),
    ),
  );
}

Expanded container_void_main() => Expanded(child: Container());

Row main_page_katilim_button() {
  return Row(
    children: [
      ElevatedButton(onPressed: () {}, child: Text('katılıcağım')),
      const SizedBox(height: 36),
      ElevatedButton(onPressed: () {}, child: Text('katılmayacağım')),
    ],
  );
}

AppBar app_bar_main() {
  return AppBar(
    title: Center(
      child: Text(
        'Ana Sayfa',
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 30),
      ),
    ),
    backgroundColor: Color.fromARGB(255, 0, 176, 245),
  );
}
