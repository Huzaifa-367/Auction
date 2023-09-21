import 'package:flutter/material.dart';

///
/// Xen Card App bar
///
class XenCardAppBar extends StatelessWidget {
  /// The main widget of the appbar
  ///
  /// [Widget] child: required
  ///
  /// example: Text, Container
  ///
  final Widget child;

  /// [Default] :
  ///
  /// BoxShadow(
  /// color: Colors.black.withOpacity(0.1),
  /// spreadRadius: 1,
  /// blurRadius: 2,
  /// offset: const Offset(1, 2)),
  ///
  /// [Tip] : use BoxShadow(color: Colors.transparent) to remove shadow and line
  final BoxShadow? shadow;

  /// [Default] : const EdgeInsets.all(10)
  ///
  /// padding for gutter widget
  final EdgeInsetsGeometry? padding;

  /// [Default] : Colors.white
  ///
  /// use to change color of appbar
  final Color? color;

  /// [Default] :  10
  ///
  /// Use to change border radius of top corners
  ///
  /// [Warning] : will require changing the gutter borderRadius
  /// to have same top and bottom border radius
  final double? borderRadius;

  const XenCardAppBar(
      {Key? key,
      required this.child,
      this.shadow,
      this.padding,
      this.color,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // size
    Size size = MediaQuery.of(context).size;
    return Container(
      // padding
      padding: padding ?? const EdgeInsets.all(20),
      // border radius
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius ?? 10),
          topRight: Radius.circular(borderRadius ?? 10),
        ),
        boxShadow: [
          shadow ??
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(1, 2),
              ),
        ],
      ),
      // appbar
      child: SizedBox(width: size.width, child: Container(child: child)),
    );
  }
}

class XenPopupCard extends StatelessWidget {
  /// The main part of the card
  ///
  /// [Widget] body: required
  ///
  /// example: ListView, Container
  ///
  final Widget body;

  /// The padding for body
  ///
  /// [Default] : 20
  ///
  final double? padding;

  /// The top part of the card
  ///
  /// [Default] : SizedBox()
  ///
  /// [XenCardAppBar] : To create a default card app bar
  ///
  /// Useful if you want to put title or navigation bar
  ///
  /// Alternatively extend the class [XenCardAppBar] to customize
  /// the app bar according to your requirement
  ///
  final XenCardAppBar? appBar;

  /// The bottom part of the card
  ///
  /// [Default] : XenCardGutter()
  ///
  /// [XenCardGutter] : To customize default gutter
  ///
  final XenCardGutter? gutter;

  /// The border radius of the card
  ///
  /// [Default] : 10
  ///
  /// Alternately you can set border by using [XenCardGutter] to set bottom border
  /// and [XenCardAppBar] to set top border
  ///
  final double? borderRadius;

  /// The background color of the card
  ///
  /// [Default] : Colors.white
  ///
  final Color? cardBgColor;

  const XenPopupCard(
      {Key? key,
      required this.body,
      this.padding,
      this.appBar,
      this.gutter,
      this.cardBgColor,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      // margin
      margin: EdgeInsets.only(
          left: size.width * 0.15 / 2,
          right: size.width * 0.15 / 2,
          top: size.height * 0.1,
          bottom: size.height * 0.1),
      // material with border radius
      child: Material(
        borderRadius: BorderRadius.circular(borderRadius ?? 20),
        color: cardBgColor ?? Colors.white,
        child: Stack(
          children: [
            // body
            Padding(
                padding: EdgeInsets.only(
                    top: appBar == null ? 20 : 80,
                    bottom: padding ?? 20,
                    left: padding ?? 20,
                    right: padding ?? 20),
                child: body),
            // appbar
            Align(
                alignment: Alignment.topCenter,
                child: appBar ?? const SizedBox()),
            // gutter
            Align(
                alignment: Alignment.bottomCenter,
                child: gutter ?? const SizedBox())
          ],
        ),
      ),
    );
  }
}
/////
///
///
///
///

/// Xen Card Gutter
class XenCardGutter extends StatelessWidget {
  /// The main widget of the gutter
  ///
  /// [Widget] child: required
  ///
  /// example: Button
  ///
  final Widget child;

  /// [Default] :
  ///
  /// BoxShadow(
  /// color: Colors.black.withOpacity(0.1),
  /// spreadRadius: 1,
  /// blurRadius: 2,
  /// offset: const Offset(1, 2)),
  ///
  /// [Tip] : use BoxShadow(color: Colors.transparent) to remove shadow and line
  final BoxShadow? shadow;

  /// [Default] :  10
  ///
  /// Use to change border radius of bottom corners
  ///
  /// [Warning] : will require changing the appbar borderRadius
  /// to have same top and bottom border radius
  final double? borderRadius;

  const XenCardGutter(
      {Key? key, required this.child, this.shadow, this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // size
    Size size = MediaQuery.of(context).size;
    // color and border radius with shadow
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(borderRadius ?? 10),
          bottomRight: Radius.circular(borderRadius ?? 10),
        ),
        boxShadow: [
          shadow ??
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(1, -2),
              ),
        ],
      ),
      // gutter
      child: SizedBox(width: size.width, child: child),
    );
  }
}
