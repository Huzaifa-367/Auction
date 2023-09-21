import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/ui/Pages/Dashboard/dashbord_view.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  static replaceTo(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  static navigateAndReplace(String routeName) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const DashboardView(),
        ),
        (route) => false);
  }
}
