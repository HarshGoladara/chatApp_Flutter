// import 'dart:js';

import 'package:chatapp/mainapp/homePage.dart';
import 'package:chatapp/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashServices {
  void isLogin(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    final user = _auth.currentUser;

    if (user != null) {
      Timer.periodic(const Duration(seconds: 3), (timer) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => homePage()));
      });
    } else {
      Timer.periodic(const Duration(seconds: 3), (timer) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => loginPage()));
      });
    }
  }
}
