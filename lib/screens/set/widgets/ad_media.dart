import 'dart:io';

import '/enums/enums.dart';
import '/widgets/video_thumbnail.dart';
import 'package:flutter/material.dart';

class AdMedia extends StatelessWidget {
  final VoidCallback onTap;
  final File? imageFile;
  final MediaFormat fileType;

  const AdMedia({
    Key? key,
    required this.onTap,
    required this.fileType,
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
            ? fileType == MediaFormat.images || fileType == MediaFormat.gifs
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.file(
                      imageFile!,
                      fit: BoxFit.cover,
                    ),
                  )
                : MediaVideoThumbnail(videoFile: imageFile!)
            : const Icon(
                Icons.add,
                size: 25.0,
              ),
      ),
    );
  }
}
