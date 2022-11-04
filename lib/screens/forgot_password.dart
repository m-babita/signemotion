import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signemotion/screens/home_screen.dart';
import 'package:signemotion/screens/register_screen.dart';
import 'package:signemotion/widgets/customizedBtn.dart';
import 'package:signemotion/widgets/customizedTxtfield.dart';

class ForgotPassword extends StatefulWidget {
  static String routeName = '/forgot_password';
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 200,
              width: 120,
              child: Image(
                image: AssetImage("assets/logos.png"),
                fit: BoxFit.contain,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                )),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Text(
                "Don't worry! Enter your email linked to your account. ",
                style: TextStyle(fontSize: 18, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
            ),
            CustomizedTextfield(
              myController: _emailController,
              hintText: "Enter your email",
              isPass: false,
            ),
            CustomizedBtn(
              btnTxt: "Send Code",
              btnColor: Colors.purple[300],
              txtColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
            ),
          ],
        ),
      ),
    ));
  }
}
