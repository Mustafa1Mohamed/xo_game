// game_utils.dart
import 'package:flutter/material.dart';

class GameUtils {
  static List<List<int>> winningCombinations = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
    [0, 4, 8], [2, 4, 6], // diagonals
  ];

  // Check for winner
  static String checkWinner(List board) {
    for (var combo in winningCombinations) {
      String a = board[combo[0]];
      String b = board[combo[1]];
      String c = board[combo[2]];
      if (a == b && b == c && a != "") {
        return a;
      }
    }
    if (!board.contains("")) {
      return "Draw";
    }
    return "";
  }

  // Build score container widget
  static Widget buildScoreContainer({
    required String player,
    required int score,
    required bool isActive,
    required BuildContext context,
  }) {
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

  // Build draw score container widget
  static Widget buildDrawContainer(int drawScore) {
    return Container(
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
    );
  }

  // Common text styles
  static TextStyle get titleStyle => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontFamily: 'second_font',
  );

  static TextStyle get contentStyle => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontFamily: 'frist_font',
  );
}
