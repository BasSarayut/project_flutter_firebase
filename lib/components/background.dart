import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 5,
            right: 0,
            child: Image.asset("assets/images/blob1.png", width: size.width),
          ),
          Positioned(
            top: 10,
            right: 10,
            child:
                Image.asset("assets/images/film.png", width: size.width * 0.55),
          ),
          Positioned(
            top: 630,
            left: 120,
            child: Image.asset("assets/images/bot22.png", width: size.width),
          ),
          Positioned(
            top: 650,
            right: 100,
            child: Image.asset("assets/images/bot.png", width: size.width),
          ),
          child
        ],
      ),
    );
  }
}
