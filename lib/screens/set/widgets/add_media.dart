import 'dart:io';

import 'package:flutter/material.dart';

class AddMedia extends StatelessWidget {
  final VoidCallback onTap;
  final File? imageFile;

  const AddMedia({
    Key? key,
    required this.onTap,
    this.imageFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Image file $imageFile');
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8.0),
        ),
        height: 70.0,
        width: 50.0,
        child: imageFile != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.file(
                  imageFile!,
                  fit: BoxFit.cover,
                ),
              )
            : const Icon(
                Icons.add,
                size: 25.0,
              ),
      ),
    );
  }
}
