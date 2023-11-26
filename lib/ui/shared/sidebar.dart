import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/Global/Global.dart';
import 'package:flutter_admin_dashboard/providers/BiddersProvider.dart';
import 'package:flutter_admin_dashboard/providers/auth_provider.dart';
import 'package:flutter_admin_dashboard/providers/side_menu_provider.dart';
import 'package:flutter_admin_dashboard/router/router.dart';
import 'package:flutter_admin_dashboard/services/navigation_service.dart';
import 'package:flutter_admin_dashboard/ui/shared/widgets/logo.dart';
import 'package:flutter_admin_dashboard/ui/shared/widgets/menu_item.dart';
import 'package:flutter_admin_dashboard/ui/shared/widgets/text_separator.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatelessWidget {
  Sidebar({super.key});

  void navigateTo(String routeName) {
    NavigationService.navigateTo(routeName);
    SideMenuProvider.closeMenu();
  }

  late BidderProvider bidderProvider;

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);
    bidderProvider = context.read<BidderProvider>();
    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const Logo(),
          const SizedBox(height: 50),
          const TextSeparator(text: 'Main'),
          if (loggedinuser!.userType != "tele") ...{
            MenuItem(
              text: 'Dashboard',
              icon: Icons.compass_calibration_outlined,
              isActive:
                  sideMenuProvider.currentPage == Flurorouter.dashboardRoute,
              onPressed: () {
                bidderProvider.setInitial();
                navigateTo(Flurorouter.dashboardRoute);
              },
            ),
          },
          if (loggedinuser!.userType != "pres") ...{
            MenuItem(
              text: 'Products',
              icon: Icons.pie_chart_rounded,
              isActive:
                  sideMenuProvider.currentPage == Flurorouter.productsRoute,
              onPressed: () {
                bidderProvider.setInitial();
                navigateTo(Flurorouter.productsRoute);
              },
            ),
          },
          if (loggedinuser!.userType == "admin") ...{
            MenuItem(
              text: 'Sold',
              icon: Icons.post_add_outlined,
              onPressed: () {
                bidderProvider.setInitial();
                navigateTo(Flurorouter.soldRoute);
              },
              isActive: sideMenuProvider.currentPage == Flurorouter.soldRoute,
            ),
            MenuItem(
              text: 'UnSold',
              icon: Icons.post_add_outlined,
              onPressed: () {
                bidderProvider.setInitial();
                navigateTo(Flurorouter.unSoldRoute);
              },
              isActive: sideMenuProvider.currentPage == Flurorouter.unSoldRoute,
            ),
            MenuItem(
              text: 'Accounts',
              icon: Icons.people_alt_outlined,
              childItems: [
                MenuItem(
                  text: 'User',
                  icon: Icons.people_alt_outlined,
                  isActive:
                      sideMenuProvider.currentPage == Flurorouter.newuserRoute,
                  onPressed: () {
                    bidderProvider.setInitial();
                    navigateTo(Flurorouter.newuserRoute);
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            // const TextSeparator(text: 'Settings'),
            // MenuItem(
            //   text: 'Settings',
            //   icon: Icons.settings,
            //   onPressed: () {
            //     bidderProvider.setInitial();
            //     navigateTo(Flurorouter.settingsRoute);
            //   },
            //   isActive:
            //       sideMenuProvider.currentPage == Flurorouter.settingsRoute,
            // ),

            MenuItem(
              text: 'Blank',
              icon: Icons.post_add_outlined,
              onPressed: () {
                bidderProvider.setInitial();
                navigateTo(Flurorouter.blankRoute);
              },
              isActive: sideMenuProvider.currentPage == Flurorouter.blankRoute,
            ),
            const SizedBox(height: 50),
          },
          const TextSeparator(text: 'Exit Panel'),
          MenuItem(
              text: 'LogOut',
              icon: Icons.exit_to_app_outlined,
              onPressed: () {
                bidderProvider.setInitial();
                Provider.of<AuthProvider>(context, listen: false).logout();
              }),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      gradient: LinearGradient(colors: [
        Color(0xff092044),
        Color(0xff092040),
      ]),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]);
}
