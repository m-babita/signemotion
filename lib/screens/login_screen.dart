import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:signemotion/screens/forgot_password.dart';
import 'package:signemotion/screens/register_screen.dart';
import 'package:signemotion/services/firebase_auth_methods.dart';
import 'package:signemotion/widgets/customizedBtn.dart';
import 'package:signemotion/widgets/customizedTxtfield.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  googleSignin() async {
    context.read<FirebaseAuthMethods>().signInWithGoogle(context);
  }

  loginUser() {
    context.read<FirebaseAuthMethods>().loginWithEmail(
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
            const Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  "Welcome Back!",
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
              myController: _emailController,
              hintText: "Enter your email",
              isPass: false,
            ),
            CustomizedTextfield(
              myController: _passController,
              hintText: "Enter your password",
              isPass: true,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, ForgotPassword.routeName);
                },
                child: Text("Forgot Password?",
                    style: TextStyle(
                      color: Colors.purple[200],
                      fontSize: 15,
                    )),
              ),
            ),
            CustomizedBtn(
                btnTxt: "Login",
                btnColor: Colors.purple[300],
                txtColor: Colors.white,
                onPressed: loginUser),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * 0.3,
                    color: Colors.grey,
                  ),
                  const Text(
                    "or Login with",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * 0.3,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.google,
                        color: Colors.purple,
                      ),
                      onPressed: googleSignin),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: Row(
                children: [
                  const Text("Don't have an account?",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      )),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ResgisterScreen.routeName);
                    },
                    child: Text("Register Now",
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
