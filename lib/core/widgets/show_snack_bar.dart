import 'package:flutter/material.dart';
import 'package:google_maps/core/theming/styles.dart';

void showSnackBar({required BuildContext context,required String message,required bool isError}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: isError ? Colors.red : Colors.green,
      content: Center(
        child: Text(
          message,
          style:  TextStyles.font18BlackW700.copyWith(color: Colors.white),
        ),
      ),
    ),
  );
}