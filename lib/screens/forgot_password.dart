import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signemotion/services/firebase_auth_methods.dart';
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
  resetWithEmail() {
    context.read<FirebaseAuthMethods>().resetPassword(
          email: _emailController.text,
          context: context,
        );
  }

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
            const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                )),
            const Padding(
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
              onPressed: resetWithEmail,
            ),
          ],
        ),
      ),
    ));
  }
}
