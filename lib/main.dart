import 'package:flutter/material.dart';
import 'package:xo_game/computer.dart';
import 'package:xo_game/freind.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.deepPurple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 70),
            Text(
              'XO Game',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.15,
                fontWeight: FontWeight.bold,
                fontFamily: 'frist_font',
              ),
            ),
            Text(
              'Tic Tac Toe',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'second_font',
              ),
            ),
            SizedBox(height: 50),
            CircleAvatar(
              radius: 170,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 160,
                backgroundImage: AssetImage('assets/images/logo.jpg'),
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Freind()),
                );
              },
              style: ButtonStyle(
                fixedSize: WidgetStatePropertyAll(Size(290, 50)),
              ),
              child: Text(
                'Play VS Freind',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.033,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'second_font',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Computer()),
                );
              },
              style: ButtonStyle(
                fixedSize: WidgetStatePropertyAll(Size(290, 50)),
              ),
              child: Text(
                'Play VS Computer',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.033,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'second_font',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
