import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AssetLottie extends StatefulWidget {
  const AssetLottie({Key? key}) : super(key: key);

  @override
  _AssetLottieState createState() => _AssetLottieState();
}

class _AssetLottieState extends State<AssetLottie> {
  //with SingleTickerProviderStateMixin {
  //late AnimationController _controller;

  //bool _isLoaded = false;

  @override
  void initState() {
    // _controller = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 20),
    // );

    // _controller.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     setState(() {
    //       _isLoaded = true;
    //     });
    //   }
    // });
    startTimer();
    super.initState();
  }

  startTimer() {
    var duration = Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() {
    Navigator.of(context).pushReplacementNamed('/onboard');
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 196, 170),
      body: Center(
        child: Lottie.asset(
          'assets/img/lf30_editor_misyvoew.json',
          //controller: _controller,
          // onLoaded: (comp) {
          //   _controller.duration = comp.duration;
          //   _controller.forward();
          // },
        ),
      ),
    );
  }
}


  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  // import 'dart:async';
// import 'dart:ffi';

// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// class Splash extends StatefulWidget {
//   const Splash({Key? key}) : super(key: key);

//   @override
//   State<Splash> createState() => _onSplash();
// }

// class _onSplash extends State<Splash> {
//   @override
//   void initState() {
//     startTimer();
//     super.initState();
//   }

//   startTimer() {
//     var duration = Duration(seconds: 5);
//     return Timer(duration, route);
//   }

//   route() {
//     Navigator.of(context).pushReplacementNamed('/onboard');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Lottie.asset(
//           'assets/img/lf30_editor_ambdaaxz.json',
//           width: 100,
//           animate: true,
//         ),
//       ),
//     );

//     // return Container(
//     //   color: Color.fromARGB(255, 249, 196, 170),
//     //   child: Container(
//     //       child: Image.asset(
//     //           "https://assets4.lottiefiles.com/packages/lf20_j0xeoest.json")),
//     // );
//   }
// }
