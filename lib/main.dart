import 'package:flutter/material.dart';
import 'package:signemotion/screens/splash.dart';
import 'package:signemotion/screens/welcomeScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Signs Emotions',
        theme: ThemeData(
          primaryColor: Colors.purple[400],
        ),
        home: const MySplash(),
      ),
    );
  }
}
