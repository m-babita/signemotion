import 'package:flutter/material.dart';
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
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              CustomizedBtn(
                btnColor: Colors.purple[200],
                btnTxt: "Emotions",
                txtColor: Colors.black,
                onPressed: () {},
              ),
              SizedBox(
                height: 50,
              ),
              CustomizedBtn(
                btnColor: Colors.purple[200],
                btnTxt: "Gestures",
                txtColor: Colors.black,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
