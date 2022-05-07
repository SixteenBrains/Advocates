import 'package:flutter/material.dart';

class OptionsButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  const OptionsButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 70.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,

            // color: isSelected ? Colors.green : Colors.white,
            border: Border.all(
                color: isSelected ? Colors.green : Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,

                ///color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}












// import '/constants/constants.dart';
// import 'package:flutter/material.dart';

// class OptionButtons extends StatelessWidget {
//   final String label;
//   final VoidCallback onTap;
//   final bool isSelected;

//   const OptionButtons({
//     Key? key,
//     required this.label,
//     required this.onTap,
//     this.isSelected = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 14.0),
//       child: SizedBox(
//         height: 64.0,
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             elevation: 0.2,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(6.0),
//               side: BorderSide(
//                 color: isSelected ? colorBrighest : Colors.grey.shade300,
//                 width: 1.0,
//               ),
//             ),
//             primary: Colors.white,
//           ),
//           onPressed: () {},
//           child: Text(
//             label,
//             style: const TextStyle(
//               fontWeight: FontWeight.w600,
//               color: Colors.black,
//               //isSelected ? Colors.white : Colors.black,
//             ),
//           ),
//         ),
//       ),

//       // GestureDetector(
//       //   onTap: onTap,
//       //   child: Container(

//       //     height: 70.0,
//       //     width: double.infinity,
//       //     child: Card(
//       //       // color: isSelected ? colorBrighest : Colors.white,
//       //       child: Center(
//       //         child: Text(
//       //           label,
//       //           style: TextStyle(
//       //             fontWeight: FontWeight.w600,
//       //             color: Colors.black,
//       //             //isSelected ? Colors.white : Colors.black,
//       //           ),
//       //         ),
//       //       ),
//       //     ),
//       //   ),
//       // ),
//     );
//   }
// }
