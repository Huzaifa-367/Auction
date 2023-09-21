import 'package:fluro/fluro.dart';
import 'package:flutter_admin_dashboard/providers/auth_provider.dart';
import 'package:flutter_admin_dashboard/providers/side_menu_provider.dart';
import 'package:flutter_admin_dashboard/router/router.dart';
import 'package:flutter_admin_dashboard/ui/Pages/Dashboard/New_User_view.dart';
import 'package:flutter_admin_dashboard/ui/Pages/Dashboard/AllProductsView.dart';
import 'package:flutter_admin_dashboard/ui/Pages/Dashboard/Setting_view.dart';
import 'package:flutter_admin_dashboard/ui/Pages/blank_view.dart';
import 'package:flutter_admin_dashboard/ui/Pages/Dashboard/dashbord_view.dart';
import 'package:flutter_admin_dashboard/ui/Pages/Auth/login_view.dart';
import 'package:provider/provider.dart';
//Products

class DashboardHandlers {
  // Dashboard
  static Handler dashboard = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.dashboardRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const DashboardView();
    } else {
      return LoginView();
    }
  });

  // All Products Handler
  static Handler allproducts = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.productsRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const AllProductsView();
    } else {
      return LoginView();
    }
  });

  // presenter Handler
  // static Handler presenter = Handler(handlerFunc: (context, parameters) {
  //   final authProvider = Provider.of<AuthProvider>(context!);
  //   Provider.of<SideMenuProvider>(context, listen: false)
  //       .setCurrentPageUrl(Flurorouter.presenterRoute);

  //   if (authProvider.authStatus == AuthStatus.authenticated) {
  //     // return PresenterView(
  //     //   product_id: 1,
  //     // );
  //   } else {
  //     return LoginView();
  //   }
  //   return null;
  // });

  // // telephonist Handler
  // static Handler telephonist = Handler(handlerFunc: (context, parameters) {
  //   final authProvider = Provider.of<AuthProvider>(context!);
  //   Provider.of<SideMenuProvider>(context, listen: false)
  //       .setCurrentPageUrl(Flurorouter.telephonistRoute);

  //   if (authProvider.authStatus == AuthStatus.authenticated) {
  //     return const TelephonistView();
  //   } else {
  //     return LoginView();
  //   }
  // });

  // // expences Handler
  // static Handler products = Handler(handlerFunc: (context, parameters) {
  //   final authProvider = Provider.of<AuthProvider>(context!);
  //   Provider.of<SideMenuProvider>(context, listen: false)
  //       .setCurrentPageUrl(Flurorouter.newuserRoute);

  //   if (authProvider.authStatus == AuthStatus.authenticated) {
  //     return const AllProductsView();
  //   } else {
  //     return LoginView();
  //   }
  // });

  // thapera Handler
  static Handler newuser = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.newuserRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const NewUserView();
    } else {
      return LoginView();
    }
    //return null;
  });

// settings Handler
  static Handler settings = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.settingsRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const SettingView();
    } else {
      return LoginView();
    }
  });

  // Blank Handler
  static Handler blank = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.blankRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const BlankView();
    } else {
      return LoginView();
    }
  });
}
