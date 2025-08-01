import 'package:flutter/material.dart';
import 'package:yazilim_toplulugu_app/pages/events_page/events_card.dart';

class events_ extends StatefulWidget {
  const events_({super.key});

  @override
  State<events_> createState() => _events_State();
}

class _events_State extends State<events_> {
  int selectedIndex = 0;
  int?
  votedIndex; // Hangi karta oy verildiğini tutar (null = henüz oy verilmedi)
  List<String> etkinlikler = [
    "Flutter Eğitimi",
    "Yapay Zeka Paneli",
    "Hackathon Etkinliği",
  ];
  Widget card_event_vote(String text, int index) {
    final bool isVoted = votedIndex != null;
    final bool isThisVoted = votedIndex == index;

    return CardEventVote(
      text: text,
      isThisVoted: isThisVoted,
      isVoted: isVoted,
      onPressed: () {
        setState(() {
          if (isThisVoted) {
            votedIndex = null;
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Oy geri çekildi.")));
          } else if (!isVoted) {
            votedIndex = index;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Teşekkürler! '$text' etkinliğine oy verdiniz."),
              ),
            );
          }
        });
      },
    );
  }

  // card_event_vote fonksiyonunu State içinde tanımlıyoruz çünkü votedIndex'e erişmesi gerekiyor:

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar_events(),
      body: SingleChildScrollView(child: card_column()),
    );
  }

  Column card_column() {
    return Column(
      children: selectedIndex == 0
          ? [
              card_event("Etkinlik: Yapay Zeka Sunumu\n21 Temmuz - Saat 21:00"),
              card_event("Etkinlik: Machine Learning\n23 Ağustos - Saat 22:00"),
              card_event("Etkinlik: Machine Learning\n23 Ağustos - Saat 22:00"),
              card_event("Etkinlik: Machine Learning\n23 Ağustos - Saat 22:00"),
              card_event("Etkinlik: Machine Learning\n23 Ağustos - Saat 22:00"),
              card_event("Etkinlik: Machine Learning\n23 Ağustos - Saat 22:00"),
              card_event("Etkinlik: Machine Learning\n23 Ağustos - Saat 22:00"),
              card_event("Etkinlik: Machine Learning\n23 Ağustos - Saat 22:00"),
              card_event("Etkinlik: Machine Learning\n23 Ağustos - Saat 22:00"),
              card_event("Etkinlik: Machine Learning\n23 Ağustos - Saat 22:00"),
              card_event("Etkinlik: Machine Learning\n23 Ağustos - Saat 22:00"),
              card_event("Etkinlik: Machine Learning\n23 Ağustos - Saat 22:00"),
            ]
          : [
              card_event_vote(
                "Etkinlik: Oyun Geliştirme Paneli\n14 Nisan - Saat 19:00",
                0,
              ),
              card_event_vote(
                "Etkinlik: Flutter 101 Eğitimi\n2 Mayıs - Saat 20:00",
                1,
              ),
            ],
    );
  }

  AppBar appbar_events() {
    return AppBar(
      backgroundColor: Color.fromARGB(225, 245, 98, 0),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(2),
        child: Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => setState(() => selectedIndex = 0),
                child: Text(
                  "yaklaşan etkinlikler",
                  style: TextStyle(
                    color: selectedIndex == 0 ? Colors.white : Colors.white70,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () => setState(() => selectedIndex = 1),
                child: Text(
                  "etkinlik oylaması ve öneriler",
                  style: TextStyle(
                    color: selectedIndex == 1 ? Colors.white : Colors.white70,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
