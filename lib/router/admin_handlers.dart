// esta clase tendra los manejadores (handlers) de manera abstracta
// no tendremos la necesidad de instanciarlos
// Para acceder a ellos pondremos "AdminHandlers.NombreDelHandler"

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/providers/auth_provider.dart';
import 'package:flutter_admin_dashboard/ui/Pages/Dashboard/dashbord_view.dart';
import 'package:flutter_admin_dashboard/ui/layouts/auth/auth_layout.dart';
import 'package:provider/provider.dart';

class AdminHandlers {
  static Handler login = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const AuthLayout(
        child: Text(''),
      );
    } else {
      return const DashboardView();
    }
  });

  // static Handler register = Handler(handlerFunc: (context, parameters) {
  //   final authProvider = Provider.of<AuthProvider>(context!);

  //   if (authProvider.authStatus == AuthStatus.notAuthenticated) {
  //     return RegisterView();
  //   } else {
  //     return const DashboardView();
  //   }
  // });
}
