// import 'package:advocates/constants/constants.dart';
// import 'package:advocates/models/set_model.dart';
// import 'package:flutter/material.dart';
// import 'package:swipe_cards/draggable_card.dart';
// import 'package:swipe_cards/swipe_cards.dart';

// class SwippingSetCard extends StatefulWidget {
//   final List<SetModel?> sets;
//   const SwippingSetCard({
//     Key? key,
//     required this.sets,
//   }) : super(key: key);

//   @override
//   State<SwippingSetCard> createState() => _SwippingSetCardState();
// }

// class _SwippingSetCardState extends State<SwippingSetCard> {
//   final List<SwipeItem> _swipeItems = [];
//   MatchEngine? _matchEngine;

//   @override
//   void initState() {
//     for (int i = 0; i < widget.sets.length; i++) {
//       _swipeItems.add(
//         SwipeItem(
//           content: Center(child: Text(widget.sets[i]?.name ?? '')),

//           // Content(text: _names[i], color: _colors[i]),
//           likeAction: () {
//             // _scaffoldKey.currentState?.showSnackBar(SnackBar(
//             //   content: Text("Liked ${_names[i]}"),
//             //   duration: Duration(milliseconds: 500),
//             // ));
//           },
//           nopeAction: () {
//             // _scaffoldKey.currentState?.showSnackBar(SnackBar(
//             //   content: Text("Nope ${_names[i]}"),
//             //   duration: Duration(milliseconds: 500),
//             // ));
//           },
//           superlikeAction: () {
//             // _scaffoldKey.currentState?.showSnackBar(SnackBar(
//             //   content: Text("Superliked ${_names[i]}"),
//             //   duration: Duration(milliseconds: 500),
//             // ));
//           },
//           onSlideUpdate: (SlideRegion? region) async {
//             print('Region $region');
//           },
//         ),
//       );
//     }

//     _matchEngine = MatchEngine(swipeItems: _swipeItems);
//     super.initState();
//   }
//  int likes = 0;
//   int views = 0;
//   int visits = 0;
//   Future<void> _showMyDialog(BuildContext context) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Image.asset(
//                 'assets/images/modal_warning.png',
//                 height: 64.0,
//                 width: 64.0,
//               ),
//               const SizedBox(height: 10.0),
//               const Text(
//                 'This action cannot be reversed, are you sure you want to do this?',
//                 style: TextStyle(fontWeight: FontWeight.w600),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 20.0),
//               SizedBox(
//                 height: 45.0,
//                 width: 200.0,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     primary: colorBrighest,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(32.0),
//                     ),
//                   ),
//                   onPressed: () {
//                     //widget.onDelete();
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text(
//                     'CONFIRM',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10.0),
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text(
//                   'CANCEL',
//                   style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           //  SingleChildScrollView(
//           //   child: ListBody(
//           //     children: const <Widget>[
//           //       Text('This is a demo alert dialog.'),
//           //       Text('Would you like to approve of this message?'),
//           //     ],
//           //   ),
//           // ),
//           // actions: <Widget>[
//           //   TextButton(
//           //     child: const Text('Approve'),
//           //     onPressed: () {
//           //       Navigator.of(context).pop();
//           //     },
//           //   ),
//           // ],
//         );
//       },
//     );
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height - kToolbarHeight,
//       child: SwipeCards(
//         onStackFinished: () {
//           print('Stack in finised');
//         },
//         itemChanged: (SwipeItem item, int index) {
//           print(' index: $index');
//           context
//               .read<SetCubit>()
//               .increaseViews(subSetId: widget.subSets[index]?.subSetId);
//         },
//         // upSwipeAllowed: true,
//         fillSpace: true,
//         matchEngine: _matchEngine!,
//         upSwipeAllowed: true,
//         itemBuilder: (BuildContext context, int index) {
//           final setModel = widget.sets[index];
//           // final _canvas = MediaQuery.of(context).size;
//           // final description = subSet?.description != null
//           //     ? subSet!.description!.length >= 175
//           //         ? subSet.description!.substring(0, 170)
//           //         : subSet.description
//           //     : 'N/A';
//           // final List<double> stops = subSet?.mediaFormat == MediaFormat.images
//           //     ? [0.2, 0.7]
//           //     : [0.2, 0.5];


//           return 
              
              
              
//               }));
//   }
// }
