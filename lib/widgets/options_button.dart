import '/constants/constants.dart';
import 'package:flutter/material.dart';

class OptionButtons extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  const OptionButtons({
    Key? key,
    required this.label,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 70.0,
          width: double.infinity,
          child: Card(
            color: isSelected ? colorBrighest : Colors.white,
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
