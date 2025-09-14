import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yazilim_toplulugu_app/pages/events_page/events_card.dart';

class events_ extends StatefulWidget {
  const events_({super.key});

  @override
  State<events_> createState() => _events_State();
}

class _events_State extends State<events_> {
  final TextEditingController suggestion_controller = TextEditingController();

  int selectedIndex = 0;
  int?
  votedIndex; // Hangi karta oy verildiğini tutar (null = henüz oy verilmedi)

  List<String> etkinlikler = [
    "Flutter Eğitimi",
    "Yapay Zeka Paneli",
    "Hackathon Etkinliği",
  ];

  @override
  void initState() {
    super.initState();
    _loadUserVote();
  }

  Future<void> _loadUserVote() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await FirebaseFirestore.instance
        .collection('event_votes')
        .get();

    for (var doc in snapshot.docs) {
      final data = doc.data();
      final List voters = data['voters'] ?? [];
      if (voters.contains(userId)) {
        final eventId = doc.id; // örn: "event_1"
        final indexStr = eventId.split('_').last;
        final index = int.tryParse(indexStr);
        if (index != null) {
          setState(() {
            votedIndex = index;
          });
          break; // İlk bulunan oy olduğu için döngüyü bitir
        }
      }
    }
  }

  Widget card_event_vote(String text, int index) {
    final bool isVoted = votedIndex != null;
    final bool isThisVoted = votedIndex == index;
    final String eventId = "event_$index";

    return CardEventVote(
      text: text,
      eventId: eventId,
      isThisVoted: isThisVoted,
      isVoted: isVoted,
      onPressed: () async {
        final userId = FirebaseAuth.instance.currentUser!.uid;
        await voteEvent(eventId, userId, text);

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
              event_card("event_1", "Yapay zeka kursu\n4 ağustos - saat 11:00"),
              event_card(
                "event_2",
                "Mikro Çip konferansı\n4 ağustos - saat 11:00",
              ),
              event_card(
                "event_3",
                "tanışma kahvaltısı\n4 ağustos - saat 11:00",
              ),
              event_card(
                "event_4",
                "Kim milyoner olmak ister\n4 ağustos - saat 11:00",
              ),
              event_card(
                "event_5",
                "Etkinlik denemesi\n4 ağustos - saat 11:00",
              ),
              event_card(
                "event_6",
                "Etkinlik denemesi\n4 ağustos - saat 11:00",
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
              suggestion_field(suggestion_controller),
              suggestion_button(),
            ],
    );
  }

  ParticipationCard event_card(String event_id, String txt) {
    return ParticipationCard(eventId: event_id, text: txt);
  }

  ElevatedButton suggestion_button() {
    return ElevatedButton(
      onPressed: () async {
        final suggestionText = suggestion_controller.text.trim();

        if (suggestionText.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Lütfen önerinizi yazınız!")),
          );
          return;
        }

        try {
          await FirebaseFirestore.instance.collection('event_suggestions').add({
            'suggestion': suggestionText,
            'timestamp': FieldValue.serverTimestamp(),
            'userId': FirebaseAuth.instance.currentUser?.uid ?? 'anonymous',
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Öneriniz başarıyla gönderildi!")),
          );

          suggestion_controller.clear();
        } catch (e) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Hata: $e")));
        }
      },
      child: const Text("etkinlik önerinizi gönderiniz"),
    );
  }

  TextField suggestion_field(TextEditingController suggestionController) {
    return TextField(
      controller: suggestionController,
      maxLines: null, // çok satırlı
      style: const TextStyle(fontSize: 18),
      decoration: InputDecoration(
        labelText: "Etkinlik Önerinizi Yazınız",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 16,
        ),
      ),
    );
  }

  AppBar appbar_events() {
    return AppBar(
      backgroundColor: const Color.fromARGB(223, 43, 50, 239),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2),
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
