import 'package:flutter/material.dart';

class UpdateAccountField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String hintText;
  final Function(String value) onChanged;
  final String? Function(String?)? validator;
  final int? minLines;
  final String? initialValue;
  final int? maxLenght;

  const UpdateAccountField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.onChanged,
    this.minLines,
    required this.validator,
    this.initialValue,
    required this.controller,
    this.maxLenght,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SizedBox(
            height: 72.0,
            width: double.infinity,
            child: Card(
              elevation: 0.5,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade400, width: 0.5),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: TextFormField(
                  controller: controller,
                  //initialValue: initialValue,
                  // minLines: 3 ?? 1,
                  //  maxLines: 4,
                  //   minLines != null ? 4 : null,
                  validator: validator,
                  onChanged: onChanged,
                  textAlign: TextAlign.center,
                  // maxLength: maxLenght,

                  style: const TextStyle(fontWeight: FontWeight.w600),
                  decoration: const InputDecoration.collapsed(
                    hintText: 'NONE',
                    hintTextDirection: TextDirection.ltr,
                  )..copyWith(
                      contentPadding: const EdgeInsets.only(
                        right: 40.0,
                        left: 40.0,
                        bottom: 20.0,
                        top: 20.0,
                      ),
                    ),
                ),
              ),
            ),
          ),
        ),
        Align(
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
      ],
    );

    // TextFormField(
    //   showCursor: true, //add this line
    //   readOnly: true,
    //   enabled: true,
    //   autofocus: isFocused,
    //   onChanged: onChanged,
    //   style: const TextStyle(fontWeight: FontWeight.w600),
    //   textAlign: TextAlign.center,
    //   textAlignVertical: TextAlignVertical.center,
    //   decoration: InputDecoration(
    //     fillColor: Colors.white,
    //     filled: true,
    //     border: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(8.0),
    //       borderSide: BorderSide(color: Colors.grey.shade400, width: 0.5),
    //     ),
    //     enabledBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(8.0),
    //       borderSide: BorderSide(color: Colors.grey.shade400, width: 0.5),
    //     ),
    //     focusedBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(8.0),
    //       borderSide: BorderSide(color: Colors.grey.shade400, width: 0.5),
    //     ),
    //     hintText: hintText,
    //     label: Align(
    //       alignment: Alignment.center,
    //       child: Chip(
    //         backgroundColor: Colors.white,
    //         label: Text(
    //           labelText,
    //           style: TextStyle(
    //             fontWeight: FontWeight.w600,
    //             color: Colors.grey.shade600,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
