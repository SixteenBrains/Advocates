import '/models/sub_set.dart';
import '/widgets/display_image.dart';
import 'package:flutter/material.dart';

class SubSetCard extends StatelessWidget {
  final SubSet? subSet;
  const SubSetCard({Key? key, required this.subSet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: DisplayImage(
              imageUrl: subSet?.imageUrl,
            ),
          ),
          Container(
            // height: 700.0,
            width: double.infinity,
            decoration: BoxDecoration(
              //color: Colors.black12,
              borderRadius: BorderRadius.circular(20.0),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.2,
                  0.7,
                  // 0.6,
                  // 0.9,
                ],
                colors: [
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
                      child: DisplayImage(imageUrl: subSet?.author?.profilePic),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    subSet?.description ?? 'N/A',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Chip(
                    backgroundColor: Colors.green,
                    label: Text(
                      subSet?.cause ?? '',
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
        ],
      ),
    );
  }
}
