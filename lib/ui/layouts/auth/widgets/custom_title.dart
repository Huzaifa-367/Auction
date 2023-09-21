import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image.asset(
          //   'twitter-white-logo.png',
          //   width: 50,
          //   height: 50,
          // ),
          const SizedBox(height: 10),
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              'Happening Now',
              style: GoogleFonts.montserratAlternates(
                fontSize: 50,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
