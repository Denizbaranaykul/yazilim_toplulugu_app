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
              widget.text,
              style: const TextStyle(
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
                    backgroundColor: userChoice == "attending"
                        ? Colors.white
                        : Colors.grey[300],
                    foregroundColor: Colors.black,
                  ),
                  child: Text("Katılacağım ($attending)"),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => submitVote("not_attending"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: userChoice == "not_attending"
                        ? Colors.white
                        : Colors.grey[300],
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
