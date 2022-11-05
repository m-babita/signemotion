import 'package:flutter/material.dart';
import 'package:signemotion/screens/welcome_screen.dart';

class MySplash extends StatefulWidget {
  static String routeName = '/splash';
  const MySplash({Key? key}) : super(key: key);

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toOnboard();
  }

  toOnboard() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacementNamed(context, WelcomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            "assets/logos.png",
            height: 100,
          ),
        ]),
      ),
    );
  }
}
