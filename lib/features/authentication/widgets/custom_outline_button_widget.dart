import 'package:flutter/material.dart';



import '../../../core/constants.dart';
import '../screens/signup_screen.dart';

class CustomOutlineButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPress;

  const CustomOutlineButtonWidget({Key? key,required this.onPress, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPress,
      style: OutlinedButton.styleFrom(
          side: BorderSide(color: midPurple, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: Size(MediaQuery.of(context).size.width / 2.6, 45),
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 28)),
      child: Text(
        text,
        style: TextStyle(
            fontFamily: font, color: midPurple, fontSize: 19, fontWeight: FontWeight.w500),
      ),
    );
  }
}
