import 'dart:io';

import 'package:advocates/widgets/video_thumbnail.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PreviewMedia extends StatelessWidget {
  final File? pickedFile;
  final FileType? fileType;
  const PreviewMedia({
    Key? key,
    required this.pickedFile,
    required this.fileType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (fileType != null && pickedFile != null) {
      if (fileType == FileType.image) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.file(
            pickedFile!,
            fit: BoxFit.cover,
          ),
        );
      } else if (fileType == FileType.video) {
        return MediaVideoThumbnail(videoFile: pickedFile!);
      }
    }
    return Image.asset(
      'assets/images/menu_upload.png',
      height: 15.0,
      width: 15.0,
      fit: BoxFit.contain,
    );
  }
}
