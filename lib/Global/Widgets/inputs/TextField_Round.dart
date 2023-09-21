import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/Global/Global.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  String? errorText;
  bool? obscureText = false;
  final Icon? prefixIcon;
  final int? maxlines;
  //final bool readonly;
  //final String? label;
  final IconData? sufixIcon;
  final TextInputType? keytype;
  final Function()? sufixIconPress;
  Function(String)? validateInput;

  MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.errorText,
    this.obscureText,
    this.prefixIcon,
    this.sufixIcon,
    this.keytype,
    this.maxlines,
    //this.readonly,
    //this.label,
    this.sufixIconPress,
    this.validateInput,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          maxLines: maxlines,
          //readOnly: readonly!,
          keyboardType: keytype,
          controller: controller,
          obscureText: obscureText!,
          cursorColor: btnColor,
          showCursor: true,
          autocorrect: true,
          onChanged: validateInput,
          enableIMEPersonalizedLearning: true,

          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.headlineSmall?.apply(
                  color: txtColor.withOpacity(0.9),
                ),
            fillColor: bkColor,
            // label: Text(
            //   label.toString(),
            //   style: GoogleFonts.gemunuLibre(
            //     fontWeight: FontWeight.w600,
            //     color: const Color.fromARGB(255, 245, 93, 93),
            //     fontSize: 15,
            //   ),
            // ),
            contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            // hintStyle: TextStyle(
            //   fontWeight: FontWeight.w700,
            //   color: btnColor,
            //   fontSize: 15,
            // ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
            ),
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(30),
            //   borderSide: BorderSide.none,
            // ),
            prefixIcon: prefixIcon,
            prefixIconColor: btnColor,
            errorText:
                errorText != null && errorText!.isNotEmpty ? errorText : null,

            // filled: true,
            suffixIcon: IconButton(
              onPressed: sufixIconPress,
              //Write Actions To Be Done

              icon: Icon(
                sufixIcon,
                //size: 20,
                color: btnColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyTextField2 extends StatelessWidget {
  final controller;
  final String hintText;
  bool? obscureText = false;
  final Icon? prefixIcon;
  final int? maxlines;
  //final bool readonly;
  //final String? label;
  final IconData? sufixIcon;
  final TextInputType? keytype;
  final Function()? onChanged;
  final Function()? sufixIconPress;

  MyTextField2({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText,
    this.prefixIcon,
    this.sufixIcon,
    this.keytype,
    this.maxlines,
    //this.readonly,
    //this.label,
    this.onChanged,
    this.sufixIconPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          maxLines: maxlines,
          //readOnly: readonly!,
          keyboardType: keytype,
          controller: controller,
          obscureText: obscureText!,
          cursorColor: btnColor,
          decoration: InputDecoration(
            hintText: hintText,
            fillColor: bkColor,
            // label: Text(
            //   label.toString(),
            //   style: GoogleFonts.gemunuLibre(
            //     fontWeight: FontWeight.w600,
            //     color: const Color.fromARGB(255, 245, 93, 93),
            //     fontSize: 15,
            //   ),
            // ),
            contentPadding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            hintStyle: TextStyle(
              fontWeight: FontWeight.w700,
              color: btnColor,
              fontSize: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            prefixIcon: prefixIcon,
            prefixIconColor: btnColor,
            filled: true,
            suffixIcon: IconButton(
              onPressed: sufixIconPress,
              //Write Actions To Be Done

              icon: Icon(
                sufixIcon,
                //size: 20,
                color: btnColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
