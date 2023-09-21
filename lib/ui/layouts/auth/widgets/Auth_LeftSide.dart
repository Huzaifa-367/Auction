import 'package:flutter/material.dart';

class BackgroundTwitter extends StatelessWidget {
  const BackgroundTwitter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Brick Kiln.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      // child: Container(
      //   constraints: const BoxConstraints(maxWidth: 400),
      //   child: const Center(
      //     child: Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 30),
      //       child: Image(
      //         image: AssetImage('assets/twitter-white-logo.png'),
      //         width: 400,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
