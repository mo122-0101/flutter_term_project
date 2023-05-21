import 'package:flutter/material.dart';

import '../../../core/constants.dart';

import './login_screen.dart';
import 'signup_screen.dart';

import '../widgets/custom_elevated_button_widget.dart';
import '../widgets/custom_outline_button_widget.dart';

class WelcomeScreen extends StatelessWidget {
  static const rn = '/welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          child: SizedBox(
            height: 380,
            width: double.infinity,
            child: Image.asset(
              'assets/images/one.webp',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: 355,
          child: Container(
            padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Speed Up',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      fontFamily: font,
                      letterSpacing: 1.2),
                ),
                const Text(
                  'Your Workflow',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      fontFamily: font,
                      letterSpacing: 1.2),
                ),
                const Text(
                  'Connect with each other with chatting or calling, Enjoy safe and private texting',
                  style: TextStyle(
                      fontSize: 17, fontFamily: font, letterSpacing: 0.2, color: Colors.black45),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomElevatedButtonWidget(
                      onPress: () {
                        Navigator.of(context).pushNamed(LoginScreen.rn);
                      },
                      text: 'Log in',
                      allWidth: false,
                    ),
                    CustomOutlineButtonWidget(
                      onPress: () {
                        Navigator.of(context).pushNamed(SignupScreen.rn);
                      },
                      text: 'Sign up',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
