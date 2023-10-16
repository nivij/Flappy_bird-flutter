import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bird.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static double birdY = 0;
  double initialPos = birdY;
  double height = 0;
  double time = 0;
  double gravity = -0.6;
  double velocity = 1.5;
  double birdWidth=0.1;
  double birdHeight=0.1;


  bool gameStart = false;

  static List<double> barrierX=[2,2 +1.5];
  static double barrierWidth=0.5;
  List<List<double>> barrierHeight=[
    [0.6,0.4],
    [0.4,0.6]
  ];
  void startGame() {
    gameStart = true;
    Timer.periodic(Duration(milliseconds: 40), (timer) {
      height = gravity * time * time + velocity * time;
      setState(() {
        birdY = initialPos - height;
      });
      if (birdisdead()) {
        timer.cancel();

        _showDialog();
      }

      time += 0.1;
    });
  }
void restartGame(){
    Navigator.pop(context);
    setState(() {

      birdY=0;
      gameStart=false;
      time=0;
      initialPos=birdY;
    });
}
  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: Center(
                child: Text(
              "G A M E    O V E R",
              style: TextStyle(color: Colors.white),
            )),
            actions: [
              GestureDetector(
                onTap: restartGame,
                 child: ClipRRect(
                   borderRadius: BorderRadius.circular(5),
                   child: Container(
                     padding: EdgeInsets.all(7),
                     color: Colors.white,
                     child:  Text(
                       "PLA Y  AGAIN",
                       style: TextStyle(color: Colors.brown),
                     ),
                   ),
                 ),
              )
            ],
          );
        });
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  bool birdisdead() {
    if (birdY < -1 || birdY > 1) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameStart ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  color: Colors.blue,
                  child: Center(
                      child: Stack(
                    children: [
                      Bird(
                        birdY: birdY,
                      ),
                      Container(
                        alignment: Alignment(0, -0.5),
                        child: Text(
                            gameStart ? "" : "T  A  P    T  O     P  L  A  Y ",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      )
                    ],
                  )),
                )),
            Expanded(
                child: Container(
              color: Colors.brown,
            )),
          ],
        ),
      ),
    );
  }
}
