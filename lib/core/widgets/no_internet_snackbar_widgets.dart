import 'package:flutter/material.dart';
import 'package:google_maps/core/helper/extensions.dart';

SnackBar noInternetSnackBarWidget(BuildContext context) {
  return SnackBar(
    content:  Text(context.localization.noInternetConnection),
    duration: const Duration(days: 1),
    action: SnackBarAction(
      label: context.localization.dismiss,
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );
}
