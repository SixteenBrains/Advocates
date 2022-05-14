// import 'package:flutter/material.dart';
// import 'package:swipe_cards/draggable_card.dart';
// import 'package:swipe_cards/swipe_cards.dart';

// class Swipping extends StatefulWidget {
//   const Swipping({Key? key, this.title}) : super(key: key);

//   final String? title;

//   @override
//   _SwippingState createState() => _SwippingState();
// }

// class _SwippingState extends State<Swipping> {
//   List<SwipeItem> _swipeItems = <SwipeItem>[];
//   MatchEngine? _matchEngine;
//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
//   List<String> _names = [
//     "Red",
//     "Blue",
//     "Green",
//     "Yellow",
//     "Orange",
//     "Grey",
//     "Purple",
//     "Pink"
//   ];
//   List<Color> _colors = [
//     Colors.red,
//     Colors.blue,
//     Colors.green,
//     Colors.yellow,
//     Colors.orange,
//     Colors.grey,
//     Colors.purple,
//     Colors.pink
//   ];

//   @override
//   void initState() {
//     for (int i = 0; i < _names.length; i++) {
//       _swipeItems.add(SwipeItem(
//           content: Content(text: _names[i], color: _colors[i]),
//           likeAction: () {
//             _scaffoldKey.currentState?.showSnackBar(SnackBar(
//               content: Text("Liked ${_names[i]}"),
//               duration: Duration(milliseconds: 500),
//             ));
//           },
//           nopeAction: () {
//             _scaffoldKey.currentState?.showSnackBar(SnackBar(
//               content: Text("Nope ${_names[i]}"),
//               duration: Duration(milliseconds: 500),
//             ));
//           },
//           superlikeAction: () {
//             _scaffoldKey.currentState?.showSnackBar(SnackBar(
//               content: Text("Superliked ${_names[i]}"),
//               duration: Duration(milliseconds: 500),
//             ));
//           },
//           onSlideUpdate: (SlideRegion? region) async {
//             print("Region $region");
//           }));
//     }

//     _matchEngine = MatchEngine(swipeItems: _swipeItems);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: Text(widget.title!),
//       ),
//       body: Container(
//         child: Stack(
//           children: [
//             Container(
//               height: MediaQuery.of(context).size.height - kToolbarHeight,
//               child: SwipeCards(
//                 matchEngine: _matchEngine!,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Container(
//                     alignment: Alignment.center,
//                     color: _swipeItems[index].content.color,
//                     child: Text(
//                       _swipeItems[index].content.text,
//                       style: TextStyle(fontSize: 100),
//                     ),
//                   );
//                 },
//                 onStackFinished: () {
//                   _scaffoldKey.currentState!.showSnackBar(SnackBar(
//                     content: Text("Stack Finished"),
//                     duration: Duration(milliseconds: 500),
//                   ));
//                 },
//                 itemChanged: (SwipeItem item, int index) {
//                   print("item: ${item.content.text}, index: $index");
//                 },
//                 upSwipeAllowed: true,
//                 fillSpace: true,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Content {
//   final String? text;
//   final Color? color;

//   Content({this.text, this.color});
// }
