import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Function(String value) onChanged;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      style: const TextStyle(fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 0.5),
        ),
        hintText: hintText,
        label: Align(
          alignment: Alignment.center,
          child: Chip(
            backgroundColor: Colors.white,
            label: Text(
              labelText,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
