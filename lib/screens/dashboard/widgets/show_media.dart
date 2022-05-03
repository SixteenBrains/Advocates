import 'package:file_picker/file_picker.dart';

import '/models/sub_set.dart';
import '/widgets/custom_video_player.dart';
import '/widgets/display_image.dart';
import 'package:flutter/material.dart';

class ShowMedia extends StatelessWidget {
  final SubSet? subSet;
  const ShowMedia({
    Key? key,
    required this.subSet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('File type ${subSet?.format == FileType.image} ');
    switch (subSet?.format) {
      case FileType.image:
        return ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: DisplayImage(imageUrl: subSet?.imageUrl),
        );
      case FileType.video:
        if (subSet?.imageUrl != null) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: CustomVideoPlayer(
              height: 200.0,
              width: double.infinity,
              videoUrl: subSet!.imageUrl!,
            ),
          );
        }
        return const SizedBox();

      default:
        return const SizedBox();
    }
  }
}
