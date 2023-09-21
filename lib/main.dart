import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/Global/Global.dart';
import 'package:flutter_admin_dashboard/practice.dart';
import 'package:flutter_admin_dashboard/providers/BiddersProvider.dart';
import 'package:flutter_admin_dashboard/providers/productsProvider.dart';
import 'package:flutter_admin_dashboard/api/cafe_api.dart';
import 'package:flutter_admin_dashboard/providers/auth_provider.dart';
import 'package:flutter_admin_dashboard/providers/register_form_provider.dart';
import 'package:flutter_admin_dashboard/providers/side_menu_provider.dart';
import 'package:flutter_admin_dashboard/router/router.dart';
import 'package:flutter_admin_dashboard/services/local_storage.dart';
import 'package:flutter_admin_dashboard/services/navigation_service.dart';
import 'package:flutter_admin_dashboard/services/notifications_service.dart';
import 'package:flutter_admin_dashboard/ui/Pages/splash/splash_View.dart';
import 'package:flutter_admin_dashboard/ui/layouts/auth/auth_layout.dart';
import 'package:flutter_admin_dashboard/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.configurePrefs();
  EasyLoading.init();
  // await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //         apiKey: "AIzaSyDn2ZFJfjHJS-Fov-G33EOwYL-00HlDWaw",
  //         authDomain: "osa-auction.firebaseapp.com",
  //         projectId: "osa-auction",
  //         storageBucket: "osa-auction.appspot.com",
  //         messagingSenderId: "719480995518",
  //         appId: "1:719480995518:web:08ec991d305cb8826568ef",
  //         measurementId: "G-5FYMSXMF9M"));

  // CafeApi.configureDio();
  Flurorouter.configureRoutes();
  configLoading();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => BidderProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => SideMenuProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => Productprovider()),
        ChangeNotifierProvider(
            lazy: false, create: (_) => RegisterFormProvider()),
      ],
      child: const MyApp(),
    );
  }
}

configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: MyHomePage(
//         title: "Background",
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'OSA Auction',
          initialRoute: loggedinuser!.userType != "tele"
              ? Flurorouter.dashboardRoute
              : Flurorouter
                  .productsRoute, // Flurorouter.root o Flurorouter.login es lo mismo
          onGenerateRoute: Flurorouter.router.generator,
          navigatorKey: NavigationService.navigatorKey,
          scaffoldMessengerKey: NotificationsService.messengerKey,
          builder: (_, child) {
            final authProvider = Provider.of<AuthProvider>(context);
            if (authProvider.authStatus == AuthStatus.checking) {
              return const SplashLayout();
            }
            if (authProvider.authStatus == AuthStatus.authenticated) {
              return DashboardLayout(child: child!);
            } else {
              return AuthLayout(child: child!);
            }
          },

          // manipulo el estilo del scrollbar
          theme: ThemeData.light(useMaterial3: true).copyWith(
            scrollbarTheme: ScrollbarThemeData(
                thumbColor: MaterialStateProperty.all(Colors.grey[500])),
          ),
        );
      },
    );
  }
}
