import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signemotion/firebase_options.dart';
import 'package:signemotion/screens/ecarousel_screen.dart';
import 'package:signemotion/screens/emotion_screen.dart';
import 'package:signemotion/screens/forgot_password.dart';
import 'package:signemotion/screens/home_screen.dart';
import 'package:signemotion/screens/login_screen.dart';
import 'package:signemotion/screens/register_screen.dart';
import 'package:signemotion/screens/scarousel_screen.dart';
import 'package:signemotion/screens/sign_screen.dart';
import 'package:signemotion/screens/splash.dart';
import 'package:signemotion/screens/welcome_screen.dart';
import 'package:signemotion/services/firebase_auth_methods.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MultiProvider(
        providers: [
          Provider<FirebaseAuthMethods>(
            create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) => context.read<FirebaseAuthMethods>().authState,
            initialData: null,
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Signs Emotions',
            theme: ThemeData(
              primaryColor: Colors.purple[400],
            ),
            home: const MySplash(),
            routes: {
              WelcomeScreen.routeName: (context) => const WelcomeScreen(),
              LoginScreen.routeName: (context) => const LoginScreen(),
              ResgisterScreen.routeName: (context) => const ResgisterScreen(),
              ForgotPassword.routeName: (context) => const ForgotPassword(),
              HomeScreen.routeName: (context) => HomeScreen(),
              ECarousel.routeName: (context) => const ECarousel(),
              SCarousel.routeName: (context) => const SCarousel(),
              EmotionScreen.routeName: (context) => const EmotionScreen(),
              SingnScreen.routeName: (context) => const SingnScreen(),
            }),
      ),
    );
  }
}
