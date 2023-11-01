import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/Global/Global.dart';

// snackBar Widget
snackBar(context, String? message, Color? color) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 5,
      backgroundColor: color ?? btnColor,
      content: Text(
        message!,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: scfColor,
          fontSize: 15,
        ),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}
