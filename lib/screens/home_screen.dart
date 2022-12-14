import 'package:flutter/material.dart';
import 'package:signemotion/screens/ecarousel_screen.dart';
import 'package:signemotion/screens/scarousel_screen.dart';
import 'package:signemotion/widgets/customizedBtn.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Signs Emotions"),
          backgroundColor: Colors.purple[200],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const SizedBox(
                  height: 200,
                  child: Image(
                    image: AssetImage("assets/emotions.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                CustomizedBtn(
                  btnColor: Colors.purple[200],
                  btnTxt: "Emotions",
                  txtColor: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, ECarousel.routeName);
                   },
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 150,
                  child: Image(
                    image: AssetImage("assets/signs.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                CustomizedBtn(
                  btnColor: Colors.purple[200],
                  btnTxt: "Gestures",
                  txtColor: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, SCarousel.routeName);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
