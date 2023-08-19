import 'package:flutter/material.dart';
import 'package:tictactoe/board_screen.dart';

void main() {
  runApp(const MaterialApp(
    title: "Tic tac toe",
    debugShowCheckedModeBanner: true,
    home: BoardScreen(),
  ));
}

