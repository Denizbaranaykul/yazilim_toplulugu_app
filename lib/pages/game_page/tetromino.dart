import 'dart:math';
import 'package:flutter/material.dart';

class Tetromino {
  final List<List<int>> shape;
  final Color color;

  Tetromino(this.shape, this.color);

  static final List<List<List<int>>> tetrominoShapes = [
    [
      [0, 0],
      [0, 1],
      [0, 2],
      [0, 3],
    ], // I
    [
      [0, 0],
      [1, 0],
      [1, 1],
      [0, 1],
    ], // O
    [
      [0, 0],
      [1, 0],
      [2, 0],
      [2, 1],
    ], // L
    [
      [0, 1],
      [1, 1],
      [2, 1],
      [2, 0],
    ], // J
    [
      [0, 0],
      [0, 1],
      [1, 1],
      [1, 2],
    ], // S
    [
      [0, 1],
      [0, 2],
      [1, 0],
      [1, 1],
    ], // Z
    [
      [0, 1],
      [1, 0],
      [1, 1],
      [1, 2],
    ], // T
  ];

  static final List<Color> tetrominoColors = [
    Colors.cyan,
    Colors.yellow,
    Colors.orange,
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.purple,
  ];

  static Tetromino random() {
    final rand = Random();
    int i = rand.nextInt(tetrominoShapes.length);
    return Tetromino(tetrominoShapes[i], tetrominoColors[i]);
  }

  Tetromino rotated() {
    List<List<int>> newShape = shape.map((p) => [p[1], -p[0]]).toList();
    int minRow = newShape.map((p) => p[0]).reduce(min);
    int minCol = newShape.map((p) => p[1]).reduce(min);
    newShape = newShape.map((p) => [p[0] - minRow, p[1] - minCol]).toList();
    return Tetromino(newShape, color);
  }
}

class TetrisPainter extends CustomPainter {
  final List<List<Color?>> grid;
  final Tetromino? piece;
  final int row, col;

  TetrisPainter(this.grid, this.piece, this.row, this.col);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (int r = 0; r < grid.length; r++) {
      for (int c = 0; c < grid[r].length; c++) {
        if (grid[r][c] != null) {
          paint.color = grid[r][c]!;
          canvas.drawRect(Rect.fromLTWH(c * 20.0, r * 20.0, 20.0, 20.0), paint);
        }
      }
    }
    if (piece != null) {
      paint.color = piece!.color;
      for (var pos in piece!.shape) {
        int r = row + pos[0];
        int c = col + pos[1];
        if (r >= 0)
          canvas.drawRect(Rect.fromLTWH(c * 20.0, r * 20.0, 20.0, 20.0), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
