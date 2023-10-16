import 'package:flutter/cupertino.dart';

class Bird extends StatelessWidget {
  final birdY;
 Bird({this.birdY});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0,birdY),

      child: Image.asset("assets/flappybird.png",width: 50),
    );
  }
}
