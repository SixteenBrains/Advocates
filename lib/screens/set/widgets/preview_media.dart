import 'dart:io';

import '/enums/enums.dart';
import '/widgets/video_thumbnail.dart';
import 'package:flutter/material.dart';

class PreviewMedia extends StatelessWidget {
  final File? pickedFile;
  final MediaFormat? mediaFormat;
  const PreviewMedia({
    Key? key,
    required this.pickedFile,
    required this.mediaFormat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('picked file widget $pickedFile');
    print('MEdia format $mediaFormat');
    if (mediaFormat != null && pickedFile != null) {
      if (mediaFormat == MediaFormat.images ||
          mediaFormat == MediaFormat.gifs) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.file(
            pickedFile!,
            fit: BoxFit.cover,
          ),
        );
      } else if (mediaFormat == MediaFormat.videos) {
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
