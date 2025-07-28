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

SizedBox triangle_box_main() {
  return SizedBox(
    width: 300,
    height: 220,
    child: Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(size: const Size(300, 220), painter: TrianglePainter()),
      ],
    ),
  );
}

Expanded container_void_main() => Expanded(child: Container());

Row main_page_katilim_button() {
  return Row(
    children: [
      ElevatedButton(onPressed: () {}, child: Text('katılıcağım')),
      const SizedBox(height: 16),
      ElevatedButton(onPressed: () {}, child: Text('katılmayacağım')),
    ],
  );
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(234, 231, 229, 229)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0) // üst tepe
      ..lineTo(0, size.height) // sol alt
      ..lineTo(size.width, size.height) // sağ alt
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

AppBar app_bar_main() {
  return AppBar(
    title: Center(child: Text('yazılım topluluğu')),
    backgroundColor: Color.fromARGB(255, 0, 176, 245),
  );
}
