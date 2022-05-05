import '/enums/enums.dart';
import '/models/set_model.dart';
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
    switch (setModel?.mediaFormat) {
      case MediaFormat.images:
        return ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: DisplayImage(imageUrl: setModel?.subsets[0]?.imageUrl),
        );
      case MediaFormat.videos:
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
