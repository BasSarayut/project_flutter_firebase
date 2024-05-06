import 'package:flutter/material.dart';
import 'package:project_flutter_fiebase/components/background.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}

class About extends StatelessWidget {
  const About({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Background(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "ABOUT",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 30),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    image(
                      assetImage: AssetImage("assets/images/keem.png"),
                    ),
                    SizedBox(height: 10),
                    name(
                      text: Text(
                        "นายพงศ์อรรถ แก่นอิน 6350110014  ICM",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 50),
                    image(
                      assetImage: AssetImage("assets/images/bas.jpg"),
                    ),
                    SizedBox(height: 10),
                    name(
                      text: Text(
                        "นายศรายุธ สิทธิเดช 6350110017  ICM",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 50),
                    image(
                      assetImage: AssetImage("assets/images/mook.jpg"),
                    ),
                    SizedBox(height: 10),
                    name(
                      text: Text(
                        "นางสาวอรอินทุ์ หวันสู 6350110022  ICM",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class name extends StatelessWidget {
  const name({Key key, this.text}) : super(key: key);

  final Text text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.amber.shade100,
        onPressed: () {},
        child: Row(
          children: [
            Image.asset(
              "assets/images/user11.png",
              width: 50,
            ),
            SizedBox(width: 30),
            Expanded(
              child: text,
            ),
          ],
        ),
      ),
    );
  }
}

class image extends StatelessWidget {
  const image({Key key, this.assetImage}) : super(key: key);

  final AssetImage assetImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        height: 115,
        width: 115,
        child: CircleAvatar(
          backgroundImage: assetImage,
        ),
      ),
    );
  }
}
