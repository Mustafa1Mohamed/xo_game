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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  // Animation controller
  late AnimationController _controller;
  late Animation<Offset> _textSlideAnimation;
  late Animation<Offset> _imageSlideAnimation;
  late Animation<Offset> _buttonsSlideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Create slide animation for image (coming from top)
    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );
    _imageSlideAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );
    // Create slide animation for buttons (coming from bottom)
    _buttonsSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );

    // Start animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            SlideTransition(
              position: _textSlideAnimation,
              child: Text(
                'XO Game',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'frist_font',
                ),
              ),
            ),
            SlideTransition(
              position: _textSlideAnimation,
              child: Text(
                'Tic Tac Toe',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'second_font',
                ),
              ),
            ),
            SizedBox(height: 50),

            // Animated image coming from top
            SlideTransition(
              position: _imageSlideAnimation,
              child: CircleAvatar(
                radius: 170,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 160,
                  backgroundImage: AssetImage('assets/images/logo.jpg'),
                ),
              ),
            ),

            SizedBox(height: 50),

            // Animated buttons coming from bottom
            SlideTransition(
              position: _buttonsSlideAnimation,
              child: Column(
                children: [
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
          ],
        ),
      ),
    );
  }
}
