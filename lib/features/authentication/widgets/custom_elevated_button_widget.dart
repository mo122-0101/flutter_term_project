import 'package:flutter/material.dart';

import '../../../core/constants.dart';




class CustomElevatedButtonWidget extends StatelessWidget {
  final String text;
  final bool allWidth;
  final VoidCallback onPress;
  bool isLoading;

  CustomElevatedButtonWidget(
      {Key? key,
      required this.onPress,
      required this.text,
      required this.allWidth,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: midPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: allWidth
            ? Size(MediaQuery.of(context).size.width, 45)
            : Size(MediaQuery.of(context).size.width / 2.6, 45),
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 28),
      ),
      child: isLoading ? CircularProgressIndicator(color: lightPurple) : Text(
        text,
        style: const TextStyle(
            fontFamily: font, color: Colors.white, fontSize: 19, fontWeight: FontWeight.w500),
      ),
    );
  }
}
