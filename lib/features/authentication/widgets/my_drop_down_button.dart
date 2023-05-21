import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/constants.dart';




class MyDropDownButton extends StatelessWidget {
  const MyDropDownButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      underline: const SizedBox(),

      items: [
        DropdownMenuItem(
          value: 'logout',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Iconsax.logout,
                color: midPurple,
              ),
              Text(
                'Log out',
                style: TextStyle(
                  fontFamily: font,
                  color: Colors.black.withOpacity(0.8),
                ),
              )
            ],
          ),
        ),
      ],
      icon: const Icon(Iconsax.bubble5, color: Colors.white,),
      onChanged: (value) {
        if(value == 'logout') {
          FirebaseAuth.instance.signOut();
        }
      },
    );
  }
}