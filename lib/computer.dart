// computer.dart
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:xo_game/game_dialogs.dart';
import 'package:xo_game/game_utils.dart';

class Computer extends StatefulWidget {
  const Computer({super.key});

  @override
  State<Computer> createState() => _ComputerState();
}

class _ComputerState extends State<Computer> {
  List sq = ["", "", "", "", "", "", "", "", ""];
  String frist = "X", winnerPlayer = "";
  int xScore = 0, oScore = 0, drawScore = 0;

  clearBoard() {
    setState(() {
      sq = ["", "", "", "", "", "", "", "", ""];
      winnerPlayer = "";
    });
  }

  Timer? time;
  startTimer(bool com) {
    time = Timer.periodic(Duration(seconds: 1), (timer) {
      clearBoard();
      if (com) {
        playComputer();
        com = false;
      } else {
        com = true;
      }
      timer.cancel();
    });
  }

  void playComputer() {
    // Get a copy of the winning combinations
    List<List<int>> winning = GameUtils.winningCombinations;

    // 1. Try to win
    for (var combo in winning) {
      String a = sq[combo[0]];
      String b = sq[combo[1]];
      String c = sq[combo[2]];
      if (a == "O" && b == "O" && c == "") {
        setState(() => sq[combo[2]] = "O");
        return;
      }
      if (a == "O" && b == "" && c == "O") {
        setState(() => sq[combo[1]] = "O");
        return;
      }
      if (a == "" && b == "O" && c == "O") {
        setState(() => sq[combo[0]] = "O");
        return;
      }
    }

    // 2. Block X from winning
    for (var combo in winning) {
      String a = sq[combo[0]];
      String b = sq[combo[1]];
      String c = sq[combo[2]];
      if (a == "X" && b == "X" && c == "") {
        setState(() => sq[combo[2]] = "O");
        return;
      }
      if (a == "X" && b == "" && c == "X") {
        setState(() => sq[combo[1]] = "O");
        return;
      }
      if (a == "" && b == "X" && c == "X") {
        setState(() => sq[combo[0]] = "O");
        return;
      }
    }

    // 3. Otherwise, pick a random empty spot
    List<int> emptyIndexes = [];
    for (int i = 0; i < sq.length; i++) {
      if (sq[i] == "") emptyIndexes.add(i);
    }
    if (emptyIndexes.isNotEmpty) {
      int move = emptyIndexes[Random().nextInt(emptyIndexes.length)];
      setState(() => sq[move] = "O");
    }
  }

  void handleWinner(String winner, bool computerStarts) {
    if (winner == 'X') {
      xScore++;
      startTimer(false);
      showGameResult('Winner', 'X is the winner!');
    } else if (winner == 'O') {
      oScore++;
      startTimer(true);
      showGameResult('Winner', 'O is the winner!');
    } else if (winner == 'Draw') {
      drawScore++;
      startTimer(false);
      showGameResult('Draw', 'It\'s a draw!');
    }
  }

  void showGameResult(String title, String content) {
    GameDialogs.showResultDialog(
      context: context,
      title: title,
      content: content,
      titleStyle: GameUtils.titleStyle,
      contentStyle: GameUtils.contentStyle,
    );
  }

  void handleTileTap(int index) {
    if (sq[index] == "") {
      setState(() {
        // Player's move
        sq[index] = "X";
        winnerPlayer = GameUtils.checkWinner(sq);

        if (winnerPlayer != "") {
          handleWinner(winnerPlayer, false);
          return;
        }

        // Computer's move
        playComputer();
        winnerPlayer = GameUtils.checkWinner(sq);

        if (winnerPlayer != "") {
          handleWinner(winnerPlayer, true);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.deepPurpleAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 30),
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.width * 0.07,
                  ),
                ),
                Text(
                  "VS Computer",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.07,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'frist_font',
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      clearBoard();
                      xScore = 0;
                      oScore = 0;
                      drawScore = 0;
                      frist = 'X';
                    });
                  },
                  icon: Icon(
                    Icons.restart_alt_outlined,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.width * 0.07,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            // Score board
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GameUtils.buildScoreContainer(
                  player: 'X',
                  score: xScore,
                  isActive: frist == 'X',
                  context: context,
                ),
                SizedBox(width: 10),
                GameUtils.buildDrawContainer(drawScore),
                SizedBox(width: 10),
                GameUtils.buildScoreContainer(
                  player: 'O',
                  score: oScore,
                  isActive: frist == 'O',
                  context: context,
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            // Current player turn
            Text(
              '$frist turn',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'second_font',
              ),
            ),
            // Game board
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: SizedBox(
                height: 440,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: sq.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => handleTileTap(index),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 5.0),
                        ),
                        child: Center(
                          child: Text(
                            sq[index],
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'frist_font',
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
