import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/constants.dart';

import '../../home/screen.dart';
import '../auth.dart';
import '../widgets/custom_elevated_button_widget.dart';
import '../widgets/custom_text_form_field.dart';

import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static const rn = '/login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  late String userEmail;
  late String userPassword;
  var _isLoading = false;

  void submittingForm() async {
    final validation = _form.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (validation) {
      setState(() {
        _isLoading = true;
      });
      _form.currentState!.save();
      try {
        await Auth.signingUserInOrUp(
            context, userEmail.trim(), userPassword.trim());
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushReplacementNamed(MyHomePage.rn);
      } catch (ex) {
        setState(() {
          _isLoading = false;
        });
        debugPrint(ex.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              height: 370,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/one.webp'),
                      fit: BoxFit.cover)),
            ),
          ),
          Positioned(
            right: 20,
            top: 45,
            child: InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(SignupScreen.rn);
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(
                      fontFamily: font, fontSize: 17, color: Colors.white),
                )),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 340,
            child: Container(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome!',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          fontFamily: font,
                          letterSpacing: 1.2),
                    ),
                    const SizedBox(height: 15),
                    Form(
                      key: _form,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            onValidate: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'please enter a valid email';
                              }
                              return null;
                            },
                            onSave: (value) {
                              userEmail = value!;
                            },
                            icon: Iconsax.message_favorite5,
                            hint: 'Email',
                            type: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 15),
                          CustomTextFormField(
                            onValidate: (value) {
                              if (value!.isEmpty || value.length < 6) {
                                return 'please enter at least 6 characters';
                              }
                              return null;
                            },
                            onSave: (value) {
                              userPassword = value!;
                            },
                            icon: Iconsax.password_check5,
                            hint: 'Password',
                            isObscure: true,
                            type: TextInputType.visiblePassword,
                          ),
                          const SizedBox(height: 25),
                          CustomElevatedButtonWidget(
                            onPress: submittingForm,
                            text: 'Continue',
                            allWidth: true,
                            isLoading: _isLoading,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
