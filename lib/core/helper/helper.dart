// this dart file responsible for showing snackBar for the user in 2 cases [errors by red color, success by orange color]
import 'package:flutter/material.dart';

import '../constants.dart';

class Helper {
  static showSnackBar(BuildContext context, Object message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        duration: const Duration(seconds: 5),
        content: Text(
          message.toString(),
          style: const TextStyle(
              fontFamily: font, letterSpacing: 0.9, color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}
