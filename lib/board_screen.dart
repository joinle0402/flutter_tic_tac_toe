import 'package:flutter/material.dart';
import 'package:tictactoe/color.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  static const String PLAYER_X = 'X';
  static const String PLAYER_O = 'O';
  static const String PLAYER_EMPTY = '';
  static const List winBoard = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  String currentPlayer = PLAYER_X;
  List<String> board = List.filled(9, PLAYER_EMPTY);
  int counter = 0;
  bool isFinished = false;

  handlePlayGame(int index) {
    if (board[index] == PLAYER_EMPTY && !isFinished) {
      setState(() {
        board[index] = currentPlayer;
        currentPlayer = currentPlayer == PLAYER_X ? PLAYER_O : PLAYER_X;
        counter++;
        checkBoard();
      });
    }
  }

  handleRepeatGame() {
    setState(() {
      currentPlayer = PLAYER_X;
      board = List.filled(9, PLAYER_EMPTY);
      counter = 0;
      isFinished = false;
    });
  }

  checkBoard() {
    for (List<int> winRow in winBoard) {
      if (board[winRow[0]] != PLAYER_EMPTY && board[winRow[0]] == board[winRow[1]] && board[winRow[0]] == board[winRow[2]]) {
        showResult("${board[winRow[0]]} is winner");
        setState(() {
          isFinished = true;
        });
        return;
      }
    }
    if (counter == board.length) {
      showResult("Draw");
      setState(() {
        isFinished = true;
      });
      return;
    }
  }

  showResult(String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(title: Text(result));
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          Text(
            "It's $currentPlayer Turn".toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 56,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child: GridView.count(
              crossAxisCount: 3,
              padding: const EdgeInsets.all(8.0),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: List.generate(board.length, (index) {
                return InkWell(
                  onTap: () { handlePlayGame(index); },
                  child: Container(
                    decoration: BoxDecoration(
                      color: GlobalColor.secondary,
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: Center(
                      child: Text(
                        // index.toString(),
                        board[index],
                        style: TextStyle(
                          color: board[index] == PLAYER_X ? Colors.blue : Colors.pink,
                          fontSize: 72,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            height: 50.0,
            child: ElevatedButton.icon(
                icon: const Icon(Icons.replay),
                label: const Text(
                  "Replay",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  )
                ),
                onPressed: () => handleRepeatGame(),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
          )
        ],
      )
    );
  }
}
