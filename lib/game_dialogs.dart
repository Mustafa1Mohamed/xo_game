// game_dialogs.dart
import 'package:flutter/material.dart';

class GameDialogs {
  static void showResultDialog({
    required BuildContext context,
    required String title,
    required String content,
    required TextStyle titleStyle,
    required TextStyle contentStyle,
    Color backgroundColor = Colors.white,
    Color buttonColor = Colors.deepPurpleAccent,
    Duration animationDuration = const Duration(milliseconds: 400),
    VoidCallback? onDismiss,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Result Dialog",
      transitionDuration: animationDuration,
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        );

        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(curvedAnimation),
          child: FadeTransition(
            opacity: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(curvedAnimation),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: backgroundColor.withOpacity(0.9),
              title: Text(
                title,
                style: titleStyle,
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    title == 'Draw' ? Icons.handshake : Icons.emoji_events,
                    size: 60,
                    color: title == 'Draw' ? Colors.blue : Colors.amber,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    content,
                    style: contentStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actions: [
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (onDismiss != null) onDismiss();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: buttonColor.withOpacity(0.2),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'OK',
                      style: contentStyle.copyWith(
                        color: buttonColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
              actionsPadding: const EdgeInsets.only(bottom: 16),
            ),
          ),
        );
      },
    );
  }
}
