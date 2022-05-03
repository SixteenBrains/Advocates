import 'package:advocates/models/set_model.dart';
import 'package:file_picker/file_picker.dart';

import '/widgets/custom_video_player.dart';
import '/widgets/display_image.dart';
import 'package:flutter/material.dart';

class ShowSetMedia extends StatelessWidget {
  final SetModel? setModel;

  const ShowSetMedia({
    Key? key,
    required this.setModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('File type ${setModel?.format == FileType.image} ');
    switch (setModel?.format) {
      case FileType.image:
        return ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: DisplayImage(imageUrl: setModel?.subsets[0]?.imageUrl),
        );
      case FileType.video:
        if (setModel?.subsets[0]?.imageUrl != null) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: CustomVideoPlayer(
              height: 200.0,
              width: double.infinity,
              videoUrl: setModel!.subsets[0]!.imageUrl!,
            ),
          );
        }
        return const SizedBox();

      default:
        return const SizedBox();
    }
  }
}
