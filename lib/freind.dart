import 'dart:async';
import 'package:flutter/material.dart';
import 'package:xo_game/game_dialogs.dart';

class Freind extends StatefulWidget {
  const Freind({super.key});

  @override
  State<Freind> createState() => _FreindState();
}

class _FreindState extends State<Freind> {
  List sq = ["", "", "", "", "", "", "", "", ""];
  String frist = "X", winnerPlayer = "";
  int xScore = 0, oScore = 0, drawScore = 0;

  final TextStyle titleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontFamily: 'second_font',
  );

  final TextStyle contentStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontFamily: 'frist_font',
  );

  clearBoard() {
    setState(() {
      sq = ["", "", "", "", "", "", "", "", ""];
      winnerPlayer = "";
    });
  }

  Timer? time;
  startTimer() {
    time = Timer.periodic(Duration(seconds: 1), (timer) {
      clearBoard();
      timer.cancel();
    });
  }

  getWinner() {
    List winning = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
      [0, 4, 8], [2, 4, 6], // diagonals
    ];
    for (var i = 0; i < winning.length; i++) {
      String a = sq[winning[i][0]];
      String b = sq[winning[i][1]];
      String c = sq[winning[i][2]];
      if (a == b && b == c && a != "") {
        return a;
      }
    }
    if (!sq.contains("")) {
      return "Draw";
    }
    return "";
  }

  void handleWinner(String winner) {
    startTimer();

    String title, content;

    if (winner == 'X') {
      frist = "X";
      xScore++;
      title = 'Winner';
      content = 'X is the winner!';
    } else if (winner == 'O') {
      frist = "O";
      oScore++;
      title = 'Winner';
      content = 'O is the winner!';
    } else {
      // Draw
      drawScore++;
      title = 'Draw';
      content = 'It\'s a draw!';
    }

    showResultDialog(title, content);
  }

  void showResultDialog(String title, String content) {
    GameDialogs.showResultDialog(
      context: context,
      title: title,
      content: content,
      titleStyle: titleStyle,
      contentStyle: contentStyle,
    );
  }

  Widget buildScoreContainer(String player, int score, bool isActive) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.33,
      height: MediaQuery.of(context).size.height * 0.22,
      decoration: BoxDecoration(
        color: isActive ? Colors.purpleAccent : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            player,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'frist_font',
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Score:',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'frist_font',
            ),
          ),
          SizedBox(height: 10),
          Text(
            '$score',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'second_font',
            ),
          ),
        ],
      ),
    );
  }

  void handleTileTap(int index) {
    if (sq[index] == "") {
      setState(() {
        sq[index] = frist;
        winnerPlayer = getWinner();

        if (winnerPlayer == 'X' ||
            winnerPlayer == 'O' ||
            winnerPlayer == 'Draw') {
          handleWinner(winnerPlayer);
        } else {
          // Switch player
          frist = (frist == 'X') ? 'O' : 'X';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  "VS Freind",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.09,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'frist_font',
                  ),
                ),
                SizedBox(width: 20),
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
                    size: 30,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildScoreContainer('X', xScore, frist == 'X'),
                SizedBox(width: 10),
                Container(
                  width: 110,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'Draw:$drawScore',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'second_font',
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                buildScoreContainer('O', oScore, frist == 'O'),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(
              '$frist turn',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'second_font',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
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
