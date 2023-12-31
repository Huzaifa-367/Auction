import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/buttons/link_text.dart';

class LinksBar extends StatelessWidget {
  const LinksBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white54,
      width: double.infinity,
      height: (size.width > 1000) ? size.height * 0.1 : null,
      child: const Wrap(
        alignment: WrapAlignment.center,
        children: [
          LinkText(text: 'About'), // onPressed: () => print('about')),
          LinkText(text: 'Help Center'),
          LinkText(text: 'Terms of Service'),
          LinkText(text: 'Privacy Policy'),
          LinkText(text: 'Cookie Policy'),
          LinkText(text: 'Ads Info'),
          LinkText(text: 'Blog'),
          LinkText(text: 'Status'),
          LinkText(text: 'Carrers'),
          LinkText(text: 'Brand Resources'),
          LinkText(text: 'Advertising'),
          LinkText(text: 'Marketing'),
        ],
      ),
    );
  }
}
