import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/Global/Global.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackBarError(String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red.withOpacity(0.9),
      content: Text(message,
          style: const TextStyle(color: Colors.white, fontSize: 20)),
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }

  static showSnackBar(String message) {
    final snackBar = SnackBar(
      backgroundColor: btnColor.withOpacity(0.9),
      content: Text(message,
          style: const TextStyle(color: Colors.white, fontSize: 20)),
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
