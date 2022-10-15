import 'package:flutter/material.dart';
import 'package:signemotion/screens/home_screen.dart';
import 'package:signemotion/screens/login_screen.dart';
import 'package:signemotion/screens/register_screen.dart';
import 'package:signemotion/widgets/customizedBtn.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/welcome.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(
              height: 200,
              width: 120,
              child: Image(
                image: AssetImage("assets/logos.png"),
                fit: BoxFit.contain,
              ),
            ),
            CustomizedBtn(
              btnTxt: "Login",
              btnColor: Colors.purple[300],
              txtColor: Colors.white,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
            ),
            CustomizedBtn(
              btnTxt: "Register",
              btnColor: Colors.purple[200],
              txtColor: Colors.white,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ResgisterScreen()));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => HomeScreen()));
                },
                child: Text("Continue as a Guest >",
                    style: TextStyle(
                      color: Colors.purple[400],
                      fontSize: 18,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
