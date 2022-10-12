import 'package:flutter/material.dart';
import 'package:signemotion/screens/emotion_screen.dart';
import 'package:signemotion/widgets/customizedBtn.dart';

class HomeScreen extends StatefulWidget {
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
          title: Text("Signs Emotions"),
          backgroundColor: Colors.purple[200],
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              SizedBox(
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => EmotionScreen()));
                },
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
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
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
