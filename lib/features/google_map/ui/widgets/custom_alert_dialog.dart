

import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    this.onPressed,
    required this.errorMessage,
    required this.buttonText,
  });

  final void Function()? onPressed;
  final String errorMessage;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(errorMessage),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}