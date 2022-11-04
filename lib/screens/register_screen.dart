import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:signemotion/screens/login_screen.dart';
import 'package:signemotion/services/firebase_auth_methods.dart';
import 'package:signemotion/widgets/customizedBtn.dart';
import 'package:signemotion/widgets/customizedTxtfield.dart';

class ResgisterScreen extends StatefulWidget {
  static String routeName = '/register';
  const ResgisterScreen({Key? key}) : super(key: key);

  @override
  State<ResgisterScreen> createState() => _ResgisterScreenState();
}

class _ResgisterScreenState extends State<ResgisterScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  void signUpUser() async {
    context.read<FirebaseAuthMethods>().signUpWithEmail(
          name: _nameController.text,
          email: _emailController.text,
          password: _passController.text,
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
            Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  "Get Started!",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              height: 200,
              width: 120,
              child: Image(
                image: AssetImage("assets/logos.png"),
                fit: BoxFit.contain,
              ),
            ),
            CustomizedTextfield(
              myController: _nameController,
              hintText: "Enter your name",
              isPass: false,
            ),
            CustomizedTextfield(
              myController: _emailController,
              hintText: "Enter your email",
              isPass: false,
            ),
            CustomizedTextfield(
              myController: _passController,
              hintText: "Enter your password",
              isPass: true,
            ),
            SizedBox(
              height: 10,
            ),
            CustomizedBtn(
                btnTxt: "Register",
                btnColor: Colors.purple[300],
                txtColor: Colors.white,
                onPressed: signUpUser),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: Row(
                children: [
                  Text("Already have an account?",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      )),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.routeName);},
                    child: Text("Login Now",
                        style: TextStyle(
                          color: Colors.purple[400],
                          fontSize: 15,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
