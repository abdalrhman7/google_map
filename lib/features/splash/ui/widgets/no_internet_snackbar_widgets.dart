import 'package:flutter/material.dart';

SnackBar noInternetSnackBarWidget(BuildContext context) {
  return SnackBar(
    content: const Text('No internet connection'),
    duration: const Duration(days: 1),
    action: SnackBarAction(
      label: 'Dismiss',
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );
}
