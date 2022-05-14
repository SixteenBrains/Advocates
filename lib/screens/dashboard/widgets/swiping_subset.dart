import 'package:advocates/screens/set/cubit/set_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/enums/enums.dart';
import '/models/sub_set.dart';
import '/widgets/display_image.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'show_media.dart';

class SwippingSubSet extends StatefulWidget {
  final List<SubSet?> subSets;

  const SwippingSubSet({
    Key? key,
    required this.subSets,
  }) : super(key: key);

  @override
  State<SwippingSubSet> createState() => _SwippingSubSetState();
}

class _SwippingSubSetState extends State<SwippingSubSet> {
  final List<SwipeItem> _swipeItems = [];
  MatchEngine? _matchEngine;

  @override
  void initState() {
    for (int i = 0; i < widget.subSets.length; i++) {
      _swipeItems.add(
        SwipeItem(
          content: Center(child: Text(widget.subSets[i]?.description ?? '')),

          // Content(text: _names[i], color: _colors[i]),
          likeAction: () {
            // _scaffoldKey.currentState?.showSnackBar(SnackBar(
            //   content: Text("Liked ${_names[i]}"),
            //   duration: Duration(milliseconds: 500),
            // ));
          },
          nopeAction: () {
            // _scaffoldKey.currentState?.showSnackBar(SnackBar(
            //   content: Text("Nope ${_names[i]}"),
            //   duration: Duration(milliseconds: 500),
            // ));
          },
          superlikeAction: () {
            // _scaffoldKey.currentState?.showSnackBar(SnackBar(
            //   content: Text("Superliked ${_names[i]}"),
            //   duration: Duration(milliseconds: 500),
            // ));
          },
          onSlideUpdate: (SlideRegion? region) async {
            print('Region $region');
          },
        ),
      );
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - kToolbarHeight,
      child: SwipeCards(
        onStackFinished: () {
          print('Stack in finised');
        },
        itemChanged: (SwipeItem item, int index) {
          print(' index: $index');
          context
              .read<SetCubit>()
              .increaseViews(subSetId: widget.subSets[index]?.subSetId);
        },
        // upSwipeAllowed: true,
        fillSpace: true,
        matchEngine: _matchEngine!,
        upSwipeAllowed: true,
        itemBuilder: (BuildContext context, int index) {
          final subSet = widget.subSets[index];
          // final _canvas = MediaQuery.of(context).size;
          final description = subSet?.description != null
              ? subSet!.description!.length >= 175
                  ? subSet.description!.substring(0, 170)
                  : subSet.description
              : 'N/A';
          final List<double> stops = subSet?.mediaFormat == MediaFormat.images
              ? [0.2, 0.7]
              : [0.2, 0.5];
          return Container(
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
              fit: subSet?.mediaFormat == MediaFormat.videos
                  ? StackFit.loose
                  : StackFit.expand,
              children: [
                ShowMedia(subSet: subSet),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    // height: 450.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      //color: Colors.black12,
                      borderRadius: BorderRadius.circular(20.0),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: stops,
                        colors: const [
                          Colors.black12,
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
                          // DescriptionTextWidget(
                          //     text: subSet?.description ?? 'N/A'),
                          Text(
                            description ?? 'N/A',
                            // subSet?.description?.substring(0, 180) ?? 'N/A',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 7.0),
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

                          const SizedBox(height: 75.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );

          // Container(
          //   alignment: Alignment.center,
          //   child: SubSetCard(
          //     subSet: widget.subSets[index],
          //   ),
          // );
        },
      ),
    );
  }
}
