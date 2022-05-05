import '/enums/enums.dart';

import '/widgets/display_image.dart';
import 'package:flutter/material.dart';

class UpdateAdMedia extends StatelessWidget {
  final VoidCallback onTap;
  final String? imageUrl;
  final MediaFormat mediaFormat;

  const UpdateAdMedia({
    Key? key,
    required this.onTap,
    required this.mediaFormat,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Image file $imageUrl');
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8.0),
        ),
        height: 70.0,
        width: 50.0,
        child: imageUrl != null
            ? mediaFormat == MediaFormat.images
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: DisplayImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                    ))
                : const Icon(
                    Icons.add,
                    size: 25.0,
                  )
            // : MediaVideoThumbnail(videoFile: imageFile!)
            : const Icon(
                Icons.add,
                size: 25.0,
              ),
      ),
    );
  }
}
