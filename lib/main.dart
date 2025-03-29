import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() => runApp(MaterialApp(debugShowCheckedModeBanner: false, title:"Speed tap game",home: SpeedTapGame()));

class SpeedTapGame extends StatefulWidget {
  @override
  _SpeedTapGameState createState() => _SpeedTapGameState();
}

class _SpeedTapGameState extends State<SpeedTapGame> {
  String message = "Press SPACE when ready!";
  bool gameStarted = false;
  late DateTime startTime;

  void startGame() {
    setState(() => message = "Be Ready...");
    Future.delayed(Duration(seconds: 2 + (DateTime.now().millisecond % 3)), () {
      setState(() {
        message = "PRESS SPACE NOW!";
        gameStarted = true;
        startTime = DateTime.now();
      });
    });
  }

  void onKeyPressed(RawKeyEvent event) {
    if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.space) {
      setState(() {
        message = gameStarted
            ? "Reaction Time: ${DateTime.now().difference(startTime).inMilliseconds} ms!"
            : "Too Soon! Try Again.";
        gameStarted = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: onKeyPressed,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(message, style: TextStyle(color: const Color.fromARGB(255, 236, 147, 147), fontSize: 24)),
              SizedBox(height: 20),
              ElevatedButton(onPressed: startGame, child: Text("Start Game")),
            ],
          ),
        ),
      ),
    );
  }
}
