// ignore_for_file: equal_keys_in_map
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:marahsebaproject/core/route/app_route.dart';
import 'package:marahsebaproject/core/route/app_route_name.dart';
import 'package:marahsebaproject/onboard.dart';
import 'package:marahsebaproject/splash.dart';
import 'package:marahsebaproject/utils/MyTheme.dart';
import 'package:marahsebaproject/utils/constants.dart';

MyTheme myTheme = new MyTheme();
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  //await MongoDatabase.connect();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => AssetLottie(),
        //'/login': (context) => LoginScreen(),
        '/onboard': (context) => onboard(),
      },
      initialRoute: AppRouteName.home,
      onGenerateRoute: AppRoute.generate,
      // },
      theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: primaryColor),
          primaryColor: primaryColor,
          dialogBackgroundColor: lightCellColor,
          brightness: Brightness.light,
          splashColor: Colors.transparent,
          backgroundColor: Color(0xFFFEF9A7)),
      themeMode: myTheme.currentTheme(),
      darkTheme: ThemeData(
        splashFactory: NoSplash.splashFactory,
        primaryColor: primaryColor,
        brightness: Brightness.dark,
        splashColor: Colors.transparent,
        dialogBackgroundColor: darkCellColor,
        backgroundColor: darkBackgroundColor,
      ),
      //home: LoginScreen(),
    );
  }
}

