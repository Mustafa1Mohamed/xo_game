// game_board.dart
import 'package:flutter/material.dart';

class GameBoard extends StatelessWidget {
  final List board;
  final Function(int) onTileTap;

  const GameBoard({super.key, required this.board, required this.onTileTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: SizedBox(
        height: 440,
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: board.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => onTileTap(index),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 5.0),
                ),
                child: Center(
                  child: Text(
                    board[index],
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
    );
  }
}
