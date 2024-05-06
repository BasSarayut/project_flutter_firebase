import 'package:flutter/material.dart';
import 'package:project_flutter_fiebase/pages/login.dart';
import 'signup.dart';

class WelcomeScreen extends StatelessWidget {
  Widget button(
    Color buttonColor,
    String title,
    Color textColor,
    GestureDetector onPressed,
  ) {
    return Container(
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 25, left: 24, right: 24),
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: buttonColor,
        onPressed: () {
          onPressed;
        },
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://img.freepik.com/free-photo/top-view-arrangement-cinema-elements-yellow-background-with-copy-space_23-2148416777.jpg?w=2000'),
                  fit: BoxFit.fill),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(top: 90, left: 25),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Text(
                        '',
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: double.infinity,
                      padding:
                          const EdgeInsets.only(top: 20, left: 24, right: 24),
                      child: RaisedButton(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        color: Colors.orangeAccent,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text(
                          "SIGN IN",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      width: double.infinity,
                      padding:
                          const EdgeInsets.only(top: 20, left: 24, right: 24),
                      child: RaisedButton(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Signup()),
                          );
                        },
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Expanded(
              //   flex: 3,
              //   child: Column(
              //     children: [
              //       button(
              //         Colors.indigo,
              //         'Sign In',
              //         Colors.white,
              //         GestureDetector(
              //           onTap: () {
              //             Navigator.pushNamed(context, Login().toString());
              //           },
              //         ),
              //       ),
              //       button(
              //         Colors.white,
              //         'Sign Up',
              //         Colors.lightBlue,
              //         GestureDetector(
              //           onTap: () {
              //             Navigator.pushNamed(context, Signup().toString());
              //           },
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
