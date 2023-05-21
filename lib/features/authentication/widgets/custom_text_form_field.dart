import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/constants.dart';




class CustomTextFormField extends StatefulWidget {
  final String? Function(String?) onValidate;
  final String? Function(String?) onSave;
  final IconData icon;
  final String hint;
  late bool isObscure;
  final TextInputType type;

  CustomTextFormField(
      {Key? key,
      required this.onValidate,
      required this.onSave,
      required this.icon,
      required this.hint,
      this.isObscure = false,
      this.type = TextInputType.text})
      : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: lightPurple.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(widget.icon, color: midPurple),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            validator: widget.onValidate,
            onSaved: widget.onSave,
            cursorColor: lightPurple.withOpacity(0.6),
            keyboardType: widget.type,
            obscureText: widget.isObscure,
            decoration: InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: lightPurple.withOpacity(0.6), width: 1),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: lightPurple.withOpacity(0.6), width: 1),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: lightPurple.withOpacity(0.6), width: 1),
              ),
              hintText: widget.hint,
              hintStyle: const TextStyle(
                color: Colors.black45,
                fontFamily: font,
              ),
              suffixIcon: widget.type == TextInputType.visiblePassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          widget.isObscure = !widget.isObscure; // isObscure = false
                        });
                      },
                      icon: Icon(
                        widget.isObscure ? Iconsax.eye4 : Iconsax.eye_slash5,
                        color: midPurple,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
