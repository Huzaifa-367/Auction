import 'package:fluro/fluro.dart';
import 'package:flutter_admin_dashboard/router/admin_handlers.dart';
import 'package:flutter_admin_dashboard/router/dashboard_handlers.dart';
import 'package:flutter_admin_dashboard/router/no_page_found_handlers.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  // Root Route
  static String rootRoute = '/dashboard/';

  // Auth Route
  static String loginRoute = '/auth/login';
  static String registerRoute = '/auth/register';

  //Dashboard Route
  static String dashboardRoute = '/dashboard';
  // static String iconsRoute = '/dashboard/icons';
  static String productsRoute = '/dashboard/products';
  static String presenterRoute = '/dashboard/presenter';
  // static String bharwaiiRoute = '/dashboard/Users/bharwaii';
  static String telephonistRoute = '/dashboard/telephonist';
  static String newuserRoute = '/dashboard/Users/newuser';
  //static String financeRoute = '/dashboard/Users/finance';
  //static String dailyRoute = '/dashboard/Users/daily';
  static String settingsRoute = '/dashboard/Users/settings';
  static String soldRoute = '/items/sold';
  static String unSoldRoute = '/items/unsold';
  static String blankRoute = '/dashboard/blank';

  //static String AllProductsRoute = '/dashboard/allproducts';

  // Configure Routes with Handlers
  static void configureRoutes() {
    // Auth Routes
    // router.define(rootRoute,
    //     handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(loginRoute,
        handler: AdminHandlers.login, transitionType: TransitionType.none);
    // router.define(registerRoute,
    //     handler: AdminHandlers.register, transitionType: TransitionType.none);

    // Dashboard Routes
    router.define(dashboardRoute,
        handler: DashboardHandlers.dashboard,
        transitionType: TransitionType.fadeIn);

    router.define(productsRoute,
        handler: DashboardHandlers.allproducts,
        transitionType: TransitionType.fadeIn);

    router.define(soldRoute,
        handler: DashboardHandlers.sold, transitionType: TransitionType.fadeIn);

    router.define(unSoldRoute,
        handler: DashboardHandlers.unsold,
        transitionType: TransitionType.fadeIn);

    router.define(newuserRoute,
        handler: DashboardHandlers.newuser,
        transitionType: TransitionType.fadeIn);

    router.define(settingsRoute,
        handler: DashboardHandlers.settings,
        transitionType: TransitionType.fadeIn);

    router.define(blankRoute,
        handler: DashboardHandlers.blank,
        transitionType: TransitionType.fadeIn);

    // 404 Error - Page not found
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}
