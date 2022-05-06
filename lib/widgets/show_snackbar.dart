import 'package:flutter/material.dart';

class ShowSnackBar {
  static void showSnackBar(
    BuildContext context, {
    required String? title,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        content: Text('$title'),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
