import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/constants.dart';
import '../../../core/helper/helper.dart';

import '../auth.dart';
import '../image_picker/user_image_picker.dart';
import 'login_screen.dart';
import '../widgets/custom_elevated_button_widget.dart';
import '../widgets/custom_text_form_field.dart';

class SignupScreen extends StatefulWidget {
  static const rn = '/signup_screen';

  const SignupScreen({Key? key}) : super(key: key);

  // File? get getUserImage {
  //   return _userImage;
  // }

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _form = GlobalKey<FormState>();
  String? _userFullName = '';
  late String _userEmail;
  late String _userPassword;
  File? _userImage;
  var _isLoading = false;
  // hold the image that the user pick it up
  var _submitWithImage =
      true; // to show red border if i try to signup without image

  void submittingForm() async {
    if (_userImage == null) {
      setState(() {
        _submitWithImage = false;
      });
    } else {
      setState(() {
        _submitWithImage = true;
      });
    }
    final validation = _form.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (validation) {
      if (_userImage == null && _userFullName != null) {
        Helper.showSnackBar(
            context, 'Please choose an image.', Colors.red.withOpacity(0.8));
      } else {
        setState(() {
          _isLoading = true;
          _submitWithImage = true;
        });
        _form.currentState!.save();
        try {
          await Auth.signingUserInOrUp(context, _userEmail.trim(),
              _userPassword.trim(), _userFullName!.trim(), _userImage);
          setState(() {
            _isLoading = false;
          });
        } catch (ex) {
          setState(() {
            _isLoading = false;
          });
          debugPrint(ex.toString());
        }
      }
    }
  }

  void _imageFn(File? image) {
    _userImage = image;
  }

  // File? get getUserImage {
  //   return _userImage;
  // }

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
              height: 350,
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
                  Navigator.of(context).pushReplacementNamed(LoginScreen.rn);
                },
                child: const Text(
                  'Sign in',
                  style: TextStyle(
                      fontFamily: font, fontSize: 17, color: Colors.white),
                )),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 320,
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
                      'New account',
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
                              if (value!.isEmpty || value.length < 4) {
                                return 'please enter at least 4 characters';
                              }
                              return null;
                            },
                            onSave: (value) {
                              _userFullName = value!;
                            },
                            icon: Iconsax.personalcard5,
                            hint: 'Full Name',
                            type: TextInputType.text,
                          ),
                          const SizedBox(height: 15),
                          CustomTextFormField(
                            onValidate: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'please enter a valid email';
                              }
                              return null;
                            },
                            onSave: (value) {
                              _userEmail = value!;
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
                              _userPassword = value!;
                            },
                            icon: Iconsax.password_check5,
                            hint: 'Password',
                            isObscure: true,
                            type: TextInputType.visiblePassword,
                          ),
                          const SizedBox(height: 25),
                          CustomElevatedButtonWidget(
                            onPress: submittingForm,
                            text: 'Create an account',
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
          UserImagePicker(
            imageFn: _imageFn,
            isValidSubmitWithImage: _submitWithImage,
          ),
        ],
      ),
    );
  }
}
