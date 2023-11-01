import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/Global/Global.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/labels/TextWidget.dart';
import 'package:flutter_admin_dashboard/providers/side_menu_provider.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: 100,
      decoration: buildBoxDecoration(),
      child: Wrap(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (size.width <= 600)
            IconButton(
              icon: const Icon(Icons.menu_outlined),
              onPressed: () => SideMenuProvider.openMenu(),
            ),
          //const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: TextWidget(
              title: "OSA Auction System",
              txtSize: 25,
              txtColor: txtColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12, left: 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 100,
              child: Row(
                children: [
                  TextWidget(
                    title: "Loggedin As: ${loggedinuser!.name}",
                    txtSize: 15,
                    txtColor: red,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/OSA.png",
                      height: 100,
                      width: 120,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/RADIO.png",
                      height: 100,
                      width: 120,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/cslogo.png",
                      height: 100,
                      width: 120,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Search box
          // if (size.width > 410)
          //   ConstrainedBox(
          //     constraints: const BoxConstraints(maxWidth: 250),
          //     child: const SearchText(),
          //   ),

          // const Spacer(),
          // const NotificationsIndicator(),

          // const SizedBox(width: 10),
          // const NavbarAvatar(),
          // const SizedBox(width: 20),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() =>
      const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 15,
        )
      ]);
}
