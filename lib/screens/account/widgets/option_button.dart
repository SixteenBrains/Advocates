// import 'package:flutter/material.dart';

// class OptionButtons extends StatelessWidget {
//   final String label;
//   final VoidCallback onTap;

//   const OptionButtons({
//     Key? key,
//     required this.label,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           height: 70.0,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border.all(color: Colors.grey.shade300),
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           child: Center(
//             child: Text(
//               label,
//               style: const TextStyle(
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
