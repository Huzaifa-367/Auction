import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/Global/Global.dart';
import 'package:google_fonts/google_fonts.dart';

class WhiteCard extends StatelessWidget {
  final String? title;
  final Widget child;
  final double? width;
  final IconData? icon;
  final IconData? backicon;
  final bool? isbackpress;
  final Function()? onPress;

  const WhiteCard({
    Key? key,
    this.title,
    this.icon,
    required this.child,
    this.width,
    this.onPress,
    this.isbackpress,
    this.backicon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 0,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isbackpress == true
                    ? InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Row(
                            children: [
                              Icon(backicon),
                              Text(title!,
                                  style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      )
                    : FittedBox(
                        fit: BoxFit.contain,
                        child: Text(title!,
                            style: GoogleFonts.roboto(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                IconButton(
                  onPressed: onPress,
                  icon: Icon(icon),
                  color: grey,
                  // hoverColor: grayshade,
                )
              ],
            ),
            const Divider()
          ],
          child
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)
        ],
      );
}
