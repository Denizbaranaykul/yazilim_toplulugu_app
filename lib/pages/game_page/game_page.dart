import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'tetromino.dart'; // Tetromino sınıfı burada olmalı
import 'leaderboard_page.dart'; // Leaderboard sayfası

class GamePage extends StatefulWidget {
  const GamePage({super.key}); // artık username parametresi yok

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static const int rowCount = 20;
  static const int colCount = 10;
  static const double blockSize = 20.0;
  String name = "";
  String surname = "";
  String email = "";
  String name_score = "";
  int score_data = 0;
  List<List<Color?>> grid = [];
  Timer? gameTimer;
  Tetromino? currentPiece;
  int currentRow = 0;
  int currentCol = 3;
  bool isGameOver = false;
  bool isStarted = false;
  int score = 0;

  @override
  void initState() {
    super.initState();
    grid = List.generate(rowCount, (_) => List.generate(colCount, (_) => null));
  }

  void startGame() {
    setState(() {
      isStarted = true;
      resetGame();
    });
  }

  void resetGame() {
    grid = List.generate(rowCount, (_) => List.generate(colCount, (_) => null));
    currentPiece = Tetromino.random();
    currentRow = 0;
    currentCol = 3;
    isGameOver = false;
    score = 0;

    gameTimer?.cancel();
    gameTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      tick();
    });
  }

  Future<void> tick() async {
    if (isGameOver) return;

    if (!moveDown()) {
      for (var pos in currentPiece!.shape) {
        int r = currentRow + pos[0];
        int c = currentCol + pos[1];
        if (r >= 0 && r < rowCount && c >= 0 && c < colCount) {
          grid[r][c] = currentPiece!.color;
        }
      }

      clearFullRows();

      currentPiece = Tetromino.random();
      currentRow = 0;
      currentCol = 3;

      if (!isValidPosition(currentPiece!, currentRow, currentCol)) {
        isGameOver = true;
        gameTimer?.cancel();
        await loadUserInfo();
        String name_surname = name + surname;
        if ((name_score ?? '').isEmpty ||
            (name_surname == name_score && score > score_data)) {
          saveScore();
        }
      }
    }
    setState(() {});
  }

  Future<void> loadUserInfo() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();
    final doc_score = await FirebaseFirestore.instance
        .collection('scores')
        .doc(uid)
        .get();

    if (doc.exists) {
      final data = doc.data()!;
      name = data['name'] ?? '';
      surname = data['surname'] ?? '';
      email = data['email'] ?? '';
    }
    if (doc_score.exists) {
      final data = doc_score.data()!;
      name_score = data['username'] ?? '';
      score_data = data['score'] ?? '';
    }
  }

  Future<void> saveScore() async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid ?? DateTime.now().millisecondsSinceEpoch.toString();

    await FirebaseFirestore.instance
        .collection("scores")
        .doc(uid) // ✅ her kullanıcıya özel belge
        .set(
          {
            "username": name.isNotEmpty ? name + surname : "Anonymous",
            "score": score,
            "timestamp": FieldValue.serverTimestamp(),
          },
          SetOptions(merge: true),
        ); // merge: true => var olan belgeyi günceller
  }

  bool moveDown() {
    if (isValidPosition(currentPiece!, currentRow + 1, currentCol)) {
      currentRow++;
      return true;
    }
    return false;
  }

  void moveLeft() {
    if (isValidPosition(currentPiece!, currentRow, currentCol - 1)) {
      setState(() {
        currentCol--;
      });
    }
  }

  void moveRight() {
    if (isValidPosition(currentPiece!, currentRow, currentCol + 1)) {
      setState(() {
        currentCol++;
      });
    }
  }

  void rotatePiece() {
    var rotated = currentPiece!.rotated();
    if (isValidPosition(rotated, currentRow, currentCol)) {
      setState(() {
        currentPiece = rotated;
      });
    }
  }

  bool isValidPosition(Tetromino piece, int row, int col) {
    for (var pos in piece.shape) {
      int r = row + pos[0];
      int c = col + pos[1];
      if (r < 0 || r >= rowCount || c < 0 || c >= colCount) return false;
      if (grid[r][c] != null) return false;
    }
    return true;
  }

  void clearFullRows() {
    for (int r = rowCount - 1; r >= 0; r--) {
      if (grid[r].every((cell) => cell != null)) {
        grid.removeAt(r);
        grid.insert(0, List.generate(colCount, (_) => null));
        score += 100;
        r++;
      }
    }
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Score: $score",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            SizedBox(height: 10),

            if (!isStarted) ...[
              ElevatedButton(onPressed: startGame, child: Text("Start Game")),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LeaderboardPage()),
                  );
                },
                child: Text("Show Leaderboard"),
              ),
            ] else ...[
              GestureDetector(
                onTap: rotatePiece,
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity != null) {
                    if (details.primaryVelocity! > 0) moveRight();
                    if (details.primaryVelocity! < 0) moveLeft();
                  }
                },
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy > 5) moveDown();
                },
                child: Container(
                  width: colCount * blockSize,
                  height: rowCount * blockSize,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                  ),
                  child: CustomPaint(
                    painter: TetrisPainter(
                      grid,
                      currentPiece,
                      currentRow,
                      currentCol,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: moveLeft,
                    icon: Icon(Icons.arrow_left, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: moveDown,
                    icon: Icon(Icons.arrow_downward, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: moveRight,
                    icon: Icon(Icons.arrow_right, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: rotatePiece,
                    icon: Icon(Icons.rotate_right, color: Colors.white),
                  ),
                ],
              ),
            ],

            if (isGameOver) ...[
              Text(
                "GAME OVER",
                style: TextStyle(color: Colors.red, fontSize: 32),
              ),
              SizedBox(height: 10),
              ElevatedButton(onPressed: resetGame, child: Text("Restart")),
            ],
          ],
        ),
      ),
    );
  }
}
