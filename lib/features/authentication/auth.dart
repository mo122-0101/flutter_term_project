import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../core/constants.dart';
import '../../core/helper/helper.dart';




class Auth {
  static Future<void> signingUserInOrUp(BuildContext context, String userEmail, String userPassword,
      [String userFullName = '', File? userImage]) async {
    final auth = FirebaseAuth.instance;
    try {
      if (userFullName.isEmpty) {
        // we are in login mode
        final credential = await auth.signInWithEmailAndPassword(
          email: userEmail,
          password: userPassword,
        );
      } else {
        // we are in signup mode
        final credential = await auth.createUserWithEmailAndPassword(
          email: userEmail,
          password: userPassword,
        );
        final storageRef = FirebaseStorage.instance.ref().child('user_image').child('${credential.user!.uid}.jpg');
        late String url;
        try {
          await storageRef.putFile(userImage!);
          url = await storageRef.getDownloadURL();
        } on FirebaseException catch (e) {
          debugPrint(e.toString());
        }

        await FirebaseFirestore.instance.collection('users').doc(credential.user!.uid).set({
          'username': userFullName,
          'email': userEmail,
          'imageurl': url,
        });
        // ignore: use_build_context_synchronously
        Helper.showSnackBar(context, 'Success Registration.', lightPurple.withOpacity(0.8));
      }
    } on FirebaseAuthException catch (ex) {
      var message = 'An error occurred';
      if (ex.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (ex.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else if (ex.code == 'weak-password') {
        message = 'can\'t use a weak password.';
      } else if (ex.code == 'email-already-in-use') {
        message = 'can\'t use an existing email.';
      }
      Helper.showSnackBar(context, message, Colors.red[300]!);
      rethrow;
    } catch (ex) {
      debugPrint(ex.toString());
      Helper.showSnackBar(context, 'error exist. please try again later.', Colors.red[300]!);
      rethrow;
    }
  }
}
