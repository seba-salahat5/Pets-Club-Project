import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marahsebaproject/MainPage.dart';
import 'package:marahsebaproject/loginsiginup/pages/login_page.dart';

class Authenticate extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return MainPage();
    } else {
      return LoginPage();
    }
  }
}
