import 'package:chatapp/firebase_Services/firebase_services.dart';
import 'package:chatapp/loginPage.dart';
import 'package:flutter/material.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}


class _splashScreenState extends State<splashScreen> {
  SplashServices splashServicess = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServicess.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient :LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.lightBlue.shade50,
                  Colors.lightBlue.shade100,
                  Colors.lightBlue.shade200,
                  Colors.lightBlue.shade300
                ]
            )
        ),
        child: Center(
          child: CircleAvatar(
            foregroundImage: AssetImage('assets/images/logo.png'),
            radius: 50,
          ),
        ),
      ),
    );
  }
}
