import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

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

  getWinner() {
    List winning = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
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

  void playComputer() {
    List<List<int>> winning = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

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
                  onPressed: () {
                    Navigator.pop(context);
                  },
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.33,
                  height: MediaQuery.of(context).size.height * 0.22,
                  decoration: BoxDecoration(
                    color: frist == 'X' ? Colors.purpleAccent : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'X',
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
                        '$xScore',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'second_font',
                        ),
                      ),
                    ],
                  ),
                ),
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
                Container(
                  width: MediaQuery.of(context).size.width * 0.33,
                  height: MediaQuery.of(context).size.height * 0.22,
                  decoration: BoxDecoration(
                    color: frist == 'O' ? Colors.purpleAccent : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'O',
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
                        '$oScore',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'second_font',
                        ),
                      ),
                    ],
                  ),
                ),
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
                      onTap: () {
                        setState(() {
                          if (sq[index] == "") {
                            if (frist == "X") {
                              sq[index] = "X";
                              winnerPlayer = getWinner();
                              if (winnerPlayer == 'X') {
                                startTimer(false);

                                xScore++;
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Winner',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontFamily: 'second_font',
                                        ),
                                      ),
                                      content: Text(
                                        'X is the winner!',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontFamily: 'frist_font',
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'OK',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontFamily: 'frist_font',
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else if (winnerPlayer == 'O') {
                                startTimer(true);
                                oScore++;
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Winner',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontFamily: 'second_font',
                                        ),
                                      ),
                                      content: Text(
                                        'O is the winner!',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontFamily: 'frist_font',
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'OK',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontFamily: 'frist_font',
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else if (winnerPlayer == 'Draw') {
                                startTimer(false);
                                drawScore++;
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Draw',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontFamily: 'second_font',
                                        ),
                                      ),
                                      content: Text(
                                        'It\'s a draw!',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontFamily: 'frist_font',
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'OK',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontFamily: 'frist_font',
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                playComputer();

                                winnerPlayer = getWinner();
                                if (winnerPlayer == 'X') {
                                  startTimer(false);

                                  xScore++;
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Winner',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontFamily: 'second_font',
                                          ),
                                        ),
                                        content: Text(
                                          'X is the winner!',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontFamily: 'frist_font',
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'OK',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontFamily: 'frist_font',
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else if (winnerPlayer == 'O') {
                                  startTimer(true);
                                  oScore++;
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Winner',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontFamily: 'second_font',
                                          ),
                                        ),
                                        content: Text(
                                          'O is the winner!',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontFamily: 'frist_font',
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'OK',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontFamily: 'frist_font',
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else if (winnerPlayer == 'Draw') {
                                  startTimer(false);
                                  drawScore++;
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Draw',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontFamily: 'second_font',
                                          ),
                                        ),
                                        content: Text(
                                          'It\'s a draw!',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontFamily: 'frist_font',
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'OK',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontFamily: 'frist_font',
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  //   } else {
                                  //     sq[index] = "O";
                                  //     winnerPlayer = getWinner();
                                  //     if (winnerPlayer == 'X') {
                                  //       startTimer();
                                  //       frist = "X";

                                  //       xScore++;
                                  //       showDialog(
                                  //         context: context,
                                  //         builder: (context) {
                                  //           return AlertDialog(
                                  //             title: Text(
                                  //               'Winner',
                                  //               style: TextStyle(
                                  //                 fontSize: 20,
                                  //                 fontWeight: FontWeight.bold,
                                  //                 color: Colors.black,
                                  //                 fontFamily: 'second_font',
                                  //               ),
                                  //             ),
                                  //             content: Text(
                                  //               'X is the winner!',
                                  //               style: TextStyle(
                                  //                 fontSize: 20,
                                  //                 fontWeight: FontWeight.bold,
                                  //                 color: Colors.black,
                                  //                 fontFamily: 'frist_font',
                                  //               ),
                                  //             ),
                                  //             actions: [
                                  //               TextButton(
                                  //                 onPressed: () {
                                  //                   Navigator.of(context).pop();
                                  //                 },
                                  //                 child: Text('OK'),
                                  //               ),
                                  //             ],
                                  //           );
                                  //         },
                                  //       );
                                  //     } else if (winnerPlayer == 'O') {
                                  //       startTimer();
                                  //       frist = "O";
                                  //       oScore++;
                                  //       showDialog(
                                  //         context: context,
                                  //         builder: (context) {
                                  //           return AlertDialog(
                                  //             title: Text(
                                  //               'Winner',
                                  //               style: TextStyle(
                                  //                 fontSize: 20,
                                  //                 fontWeight: FontWeight.bold,
                                  //                 color: Colors.black,
                                  //                 fontFamily: 'second_font',
                                  //               ),
                                  //             ),
                                  //             content: Text(
                                  //               'O is the winner!',
                                  //               style: TextStyle(
                                  //                 fontSize: 20,
                                  //                 fontWeight: FontWeight.bold,
                                  //                 color: Colors.black,
                                  //                 fontFamily: 'frist_font',
                                  //               ),
                                  //             ),
                                  //             actions: [
                                  //               TextButton(
                                  //                 onPressed: () {
                                  //                   Navigator.of(context).pop();
                                  //                 },
                                  //                 child: Text('OK'),
                                  //               ),
                                  //             ],
                                  //           );
                                  //         },
                                  //       );
                                  //     } else if (winnerPlayer == 'Draw') {
                                  //       startTimer();
                                  //       drawScore++;
                                  //       showDialog(
                                  //         context: context,
                                  //         builder: (context) {
                                  //           return AlertDialog(
                                  //             title: Text(
                                  //               'Draw',
                                  //               style: TextStyle(
                                  //                 fontSize: 20,
                                  //                 fontWeight: FontWeight.bold,
                                  //                 color: Colors.black,
                                  //                 fontFamily: 'second_font',
                                  //               ),
                                  //             ),
                                  //             content: Text(
                                  //               'It\'s a draw!',
                                  //               style: TextStyle(
                                  //                 fontSize: 20,
                                  //                 fontWeight: FontWeight.bold,
                                  //                 color: Colors.black,
                                  //                 fontFamily: 'frist_font',
                                  //               ),
                                  //             ),
                                  //             actions: [
                                  //               TextButton(
                                  //                 onPressed: () {
                                  //                   Navigator.of(context).pop();
                                  //                 },
                                  //                 child: Text('OK'),
                                  //               ),
                                  //             ],
                                  //           );
                                  //         },
                                  //       );
                                  //     } else {
                                  //       frist = 'X';
                                  //     }
                                  //   }
                                  // }
                                }
                              }
                            }
                          }
                        });
                      },
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
