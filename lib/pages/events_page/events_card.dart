import 'package:flutter/material.dart';
import 'package:yazilim_toplulugu_app/pages/main_page/main_page_body.dart';

Card card_event(String text) {
  return Card(
    color: const Color.fromARGB(244, 181, 7, 71),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
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

class CardEventVote extends StatelessWidget {
  final String text;
  final bool isThisVoted;
  final bool isVoted;
  final VoidCallback onPressed;

  const CardEventVote({
    super.key,
    required this.text,
    required this.isThisVoted,
    required this.isVoted,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(244, 39, 7, 181),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onPressed,
              child: Text(
                isThisVoted
                    ? "Oyu Geri Çek"
                    : isVoted
                    ? "Oy Verilemez"
                    : "Oy Ver",
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: (isThisVoted || !isVoted)
                    ? Colors.white
                    : Colors.grey,
                foregroundColor: const Color.fromARGB(244, 39, 7, 181),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
