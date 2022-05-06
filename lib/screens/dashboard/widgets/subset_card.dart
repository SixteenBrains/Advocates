import 'package:advocates/enums/enums.dart';

import '/screens/dashboard/widgets/show_media.dart';
import '/models/sub_set.dart';
import '/widgets/display_image.dart';
import 'package:flutter/material.dart';

import 'discription_text.dart';

class SubSetCard extends StatelessWidget {
  final SubSet? subSet;
  const SubSetCard({Key? key, required this.subSet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('cause -- ${subSet?.setModel?.cause}');
    final List<double> stops =
        subSet?.mediaFormat == MediaFormat.images ? [0.2, 0.7] : [0.2, 0.5];
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        height: 500.0,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.4],
            colors: [
              Colors.black87,
              Colors.black38,
            ],
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Stack(
          fit: subSet?.mediaFormat == MediaFormat.images
              ? StackFit.expand
              : StackFit.loose,
          children: [
            ShowMedia(subSet: subSet),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 400.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  //color: Colors.black12,
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: stops,
                    colors: const [
                      Colors.transparent,
                      Colors.black87,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        child: ClipOval(
                          child: DisplayImage(
                              imageUrl: subSet?.author?.profilePic),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      DescriptionTextWidget(text: subSet?.description ?? 'N/A'),
                      // Text(
                      //   subSet?.description ?? 'N/A',
                      //   style: const TextStyle(
                      //     color: Colors.white,
                      //     fontWeight: FontWeight.w600,
                      //     fontSize: 16.0,
                      //   ),
                      // ),
                      //   const SizedBox(height: 10.0),
                      Chip(
                        backgroundColor: Colors.green,
                        label: Text(
                          subSet?.setModel?.cause ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        ' ${subSet?.destination ?? ' '}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
