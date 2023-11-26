import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/Global/Global.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackBarError(String message) {
    final snackBar = SnackBar(
      elevation: 5,
      backgroundColor: btnColor,
      content: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: scfColor,
          fontSize: 15,
        ),
      ),
      duration: const Duration(seconds: 2),
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }

  static showSnackBar(String message) {
    final snackBar = SnackBar(
      elevation: 5,
      backgroundColor: btnColor,
      content: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: scfColor,
          fontSize: 15,
        ),
      ),
      duration: const Duration(seconds: 2),
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
