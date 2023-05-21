import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants.dart';



class UserImagePicker extends StatefulWidget {
  final void Function(File?) imageFn;
  final bool isValidSubmitWithImage;
  const UserImagePicker({Key? key, required this.imageFn, required this.isValidSubmitWithImage}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 70, maxWidth: 300);
    setState(() {
      _pickedImage = File(image!.path);
    });
    widget.imageFn(File(image!.path));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 30,
          top: 280,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                color: midPurple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(width: 3, color: widget.isValidSubmitWithImage ? Colors.white: Colors.red.withOpacity(0.6)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 2),
                      blurRadius: 5,
                      spreadRadius: 2)
                ],),
            child: _pickedImage == null
                ? null
                : ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.file(
                      _pickedImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
        Positioned(
          right: 28,
          top: 338,
          child: Container(
              alignment: Alignment.center,
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: midPurple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: _pickImage,
                icon: Icon(
                  Iconsax.camera5,
                  color: midPurple,
                  size: 20,
                ),
              )),
        ),
      ],
    );
  }
}
