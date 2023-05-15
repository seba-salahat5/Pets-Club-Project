// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:marahsebaproject/loginsiginup/pages/login_page.dart';

class onboard extends StatefulWidget {
  const onboard({Key? key}) : super(key: key);

  @override
  State<onboard> createState() => _OnboardState();
}

class _OnboardState extends State<onboard> {
  @override
  Widget build(BuildContext context) {
    List<Container> pages;
    return Scaffold(
      body: LiquidSwipe(
        pages: pages = [
          Container(
            width: double.infinity,
            color: Color.fromARGB(255, 216, 175, 252),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Image.asset(
                    "assets/img/abood.gif",
                    height: 400,
                    width: 400,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                    " We have a large variety of\n pet products such as                     food,clothing, and games.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: Color.fromARGB(255, 184, 214, 245),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Image.asset(
                     "assets/img/output-onlinegiftools (6).gif",
                    
                    height: 400,
                    width: 400,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                    " you can buy,sale or adopt a pet through our app. ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: Color.fromARGB(255, 243, 186, 248),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Image.asset(
                    "assets/img/output-onlinegiftools (2).gif",
                    height: 400,
                    width: 400,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                    " We will provide you with a list of nearby Veterinary Centers.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: Color.fromARGB(255, 207, 166, 243),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 20),
                    child: Text(
                      'Welcome in our application',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(214, 28, 78, 1.000),
                        fontSize: 22,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 30),
                    child: Text(
                      '  we are very happy that you \njoined our application        ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(69, 90, 100, 1.000),
                        fontSize: 18,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Image.asset(
                    "assets/img/My project (3).png",
                    height: 400,
                    width: 400,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.topCenter,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4F3268),
                        side: const BorderSide(
                            color: Color(0xFF4F3268), width: 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => LoginPage())));
                      },
                      child: const Text(
                        "Let's go",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70.0,
                ),
              ],
            ),
          ),
        ], //
        enableLoop: false,
        fullTransitionValue: 300,
        enableSideReveal: true,
        waveType: WaveType.liquidReveal,
        positionSlideIcon: 0.8,
      ),
    );
  }
}
