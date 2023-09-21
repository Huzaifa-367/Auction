import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/Global/Global.dart';

class ButtonWidget extends StatelessWidget {
  final String btnText;
  final VoidCallback onPress;
  //bool? isloading = false;

  const ButtonWidget({
    Key? key,
    required this.btnText,
    required this.onPress,
    // this.isloading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        shadowColor: const Color.fromARGB(177, 134, 180, 255),
        //primary: Theme.of(context).secondaryHeaderColor,
        backgroundColor: btnColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      child: FittedBox(
        child: Text(
          btnText.toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
