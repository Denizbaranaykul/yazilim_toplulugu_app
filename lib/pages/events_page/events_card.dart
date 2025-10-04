import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ParticipationCard extends StatefulWidget {
  final String eventId;
  final String text;

  const ParticipationCard({
    super.key,
    required this.eventId,
    required this.text,
  });

  @override
  State<ParticipationCard> createState() => _ParticipationCardState();
}

class _ParticipationCardState extends State<ParticipationCard> {
  String? userChoice;
  int attending = 0;
  int notAttending = 0;

  @override
  void initState() {
    super.initState();
    fetchVoteStatus();
  }

  Future<void> fetchVoteStatus() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final docRef = FirebaseFirestore.instance
        .collection('participation_votes')
        .doc(widget.eventId);
    final doc = await docRef.get();

    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        attending = data['attending'] ?? 0;
        notAttending = data['not_attending'] ?? 0;
        final voters = Map<String, dynamic>.from(data['voters'] ?? {});
        userChoice = voters[userId];
      });
    }
  }

  Future<void> submitVote(String choice) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final docRef = FirebaseFirestore.instance
        .collection('participation_votes')
        .doc(widget.eventId);
    final doc = await docRef.get();

    Map<String, dynamic> voters = {};
    String? previousChoice;

    if (doc.exists) {
      voters = Map<String, dynamic>.from(doc['voters'] ?? {});
      previousChoice = voters[userId];
    }

    // Aynı seçeneğe tıklarsa bir şey yapma
    if (previousChoice == choice) return;

    // Sayıları güncelle
    int newAttending = attending;
    int newNotAttending = notAttending;

    if (previousChoice == 'attending') newAttending--;
    if (previousChoice == 'not_attending') newNotAttending--;

    if (choice == 'attending') newAttending++;
    if (choice == 'not_attending') newNotAttending++;

    voters[userId] = choice;

    await docRef.set({
      'attending': newAttending,
      'not_attending': newNotAttending,
      'voters': voters,
    });

    setState(() {
      attending = newAttending;
      notAttending = newNotAttending;
      userChoice = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color card_color = Color.fromARGB(
      244,
      41,
      156,
      228,
    ); // kartın arka plan rengi
    Color button_color_attending =
        Colors.white; // katılacağım butonunun arkaplan rengi
    Color button_color_not_attending =
        Colors.white; // katılmayacağım butonunun arkaplan rengi
    if (userChoice == "attending") //kullanıcı eçimi katılacağımas
    {
      card_color = Colors.green;
      button_color_attending = Colors.white;
      button_color_not_attending = Colors.grey;
    } else if (userChoice == "not_attending") //katılmayacağımsa
    {
      card_color = Colors.redAccent;
      button_color_not_attending = Colors.white;
      button_color_attending = Colors.grey;
    }
    return AnimatedContainer(
      //animasyonlu konteynira aldım kartı ki rengi değişsin
      duration: const Duration(milliseconds: 300), //gerçekleşme süresi
      curve: Curves.easeInOut, //geçişin tipi
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ), //ssasğdan soldan verdiği boşluk kartın ta kendisi
      decoration: BoxDecoration(
        color: card_color, //rengi değişkenden alıyorum ki geçiş başlasın
        borderRadius: BorderRadius.circular(
          12,
        ), //burda kenarların yuvarlak olmasını sağlıyorum
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          10.0,
        ), //kartın içinde ki öğelerle arasında ki boşluk
        child: Column(
          mainAxisSize: MainAxisSize
              .min, // sütunda ne kadarlık alan kaplıycaqğını belirtiyor burda en az verdim
          crossAxisAlignment: CrossAxisAlignment
              .center, //çapraz ekende itemlerin sıralanmaya başlayacağı yeri belirtiyor
          children: [
            Text(
              widget.text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => submitVote("attending"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: button_color_attending,
                    foregroundColor: Colors.black,
                  ),
                  child: Text("Katılacağım ($attending)"),
                ),
                const SizedBox(width: 6),
                ElevatedButton(
                  onPressed: () => submitVote("not_attending"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: button_color_not_attending,
                    foregroundColor: Colors.black,
                  ),
                  child: Text("Katılmayacağım ($notAttending)"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CardEventVote extends StatelessWidget {
  final String text;
  final String eventId;
  final bool isThisVoted;
  final bool isVoted;
  final VoidCallback onPressed; // ← Bunu ekle!
  const CardEventVote({
    super.key,
    required this.text,
    required this.eventId,
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
              onPressed: (isVoted && !isThisVoted) ? null : onPressed,
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

Future<void> voteEvent(String eventId, String userId, String eventText) async {
  final docRef = FirebaseFirestore.instance
      .collection('event_votes')
      .doc(eventId);

  final doc = await docRef.get();

  if (doc.exists) {
    final data = doc.data()!;
    final List voters = data['voters'] ?? [];

    if (voters.contains(userId)) {
      // Oy Geri Çekme
      voters.remove(userId);
      await docRef.update({
        'votes': FieldValue.increment(-1),
        'voters': voters,
      });
    } else {
      // Oy Verme
      voters.add(userId);
      await docRef.update({'votes': FieldValue.increment(1), 'voters': voters});
    }
  } else {
    // İlk defa oy veriliyorsa yeni belge oluştur
    await docRef.set({
      'text': eventText,
      'votes': 1,
      'voters': [userId],
    });
  }
}
