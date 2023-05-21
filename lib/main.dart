import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/firebase_options.dart';
import 'features/authentication/screens/login_screen.dart';
import 'features/authentication/screens/signup_screen.dart';
import 'features/authentication/screens/welcome_screen.dart';
import 'features/home/screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FlutterChat());
  /*
  cc4hJP-VT1mBHv9OWcnO4l:APA91bHWmq3_6gvGyCBhOisJXT1MpGt4Zh_GfrzFX2w0tG1Eyx3tD_4EF68-N4ZGkvlD5y3cEpjY_kqFhaX34k78oIs6B5Hk4q4TyGMMLc7m3JMKX36jMZemo4Y7S7yWnsOJA1aGbkUs
   */
}

class FlutterChat extends StatelessWidget {
  const FlutterChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MyHomePage();
          }
          return const WelcomeScreen();
        },
      ),
      routes: {
        WelcomeScreen.rn: (context) => const WelcomeScreen(),
        LoginScreen.rn: (context) => const LoginScreen(),
        SignupScreen.rn: (context) => const SignupScreen(),
        MyHomePage.rn: (context) => const MyHomePage(),
      },
    );
  }
}
