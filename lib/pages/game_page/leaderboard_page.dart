import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Leaderboard")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("scores")
            .orderBy("score", descending: true)
            .limit(20)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data(); // Map<String, dynamic>?
              final username = data['username'] ?? 'Unknown';
              final score = data['score'] ?? 0;

              return ListTile(
                leading: Text("#${index + 1}"),
                title: Text(username),
                trailing: Text("$score"),
              );
            },
          );
        },
      ),
    );
  }
}
