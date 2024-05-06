import 'package:flutter/material.dart';

class Background2 extends StatelessWidget {
  final Widget child;

  const Background2({
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
            top: 565,
            left: 120,
            child: Image.asset("assets/images/bot22.png", width: size.width),
          ),
          Positioned(
            top: 555,
            right: 100,
            child: Image.asset("assets/images/bot.png", width: size.width),
          ),
          child
        ],
      ),
    );
  }
}
