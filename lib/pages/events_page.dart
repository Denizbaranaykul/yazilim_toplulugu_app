import 'package:flutter/material.dart';
import 'package:yazilim_toplulugu_app/main_page/main_page_body.dart';

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

  // card_event_vote fonksiyonunu State içinde tanımlıyoruz çünkü votedIndex'e erişmesi gerekiyor:

  Widget card_event_vote(String text, int index) {
    final bool isVoted = votedIndex != null;
    final bool isThisVoted = votedIndex == index;

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
              onPressed: () {
                setState(() {
                  if (isThisVoted) {
                    votedIndex = null; // Oy geri çekildi
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Oy geri çekildi."),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else if (!isVoted) {
                    votedIndex = index; // Yeni oy verildi
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Teşekkürler! '${text}' etkinliğine oy verdiniz.",
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                });
              },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: selectedIndex == 0
              ? [
                  card_event(
                    "Etkinlik: Yapay Zeka Sunumu\n21 Temmuz - Saat 21:00",
                  ),
                  card_event(
                    "Etkinlik: Machine Learning\n23 Ağustos - Saat 22:00",
                  ),
                  card_event(
                    "Etkinlik: Machine Learning\n23 Ağustos - Saat 22:00",
                  ),
                  card_event(
                    "Etkinlik: Machine Learning\n23 Ağustos - Saat 22:00",
                  ),
                  card_event(
                    "Etkinlik: Machine Learning\n23 Ağustos - Saat 22:00",
                  ),
                  card_event(
                    "Etkinlik: Machine Learning\n23 Ağustos - Saat 22:00",
                  ),
                  card_event(
                    "Etkinlik: Machine Learning\n23 Ağustos - Saat 22:00",
                  ),
                  card_event(
                    "Etkinlik: Machine Learning\n23 Ağustos - Saat 22:00",
                  ),
                  card_event(
                    "Etkinlik: Machine Learning\n23 Ağustos - Saat 22:00",
                  ),
                  card_event(
                    "Etkinlik: Machine Learning\n23 Ağustos - Saat 22:00",
                  ),
                  card_event(
                    "Etkinlik: Machine Learning\n23 Ağustos - Saat 22:00",
                  ),
                  card_event(
                    "Etkinlik: Machine Learning\n23 Ağustos - Saat 22:00",
                  ),
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
        ),
      ),
    );
  }

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
}
