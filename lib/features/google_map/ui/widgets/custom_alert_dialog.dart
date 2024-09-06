

import 'package:flutter/material.dart';
import 'package:google_maps/core/theming/styles.dart';

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
            style: TextStyles.font14BlackW500.copyWith(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}