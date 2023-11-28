import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/inputs/TextField_Round.dart';
import 'package:flutter_admin_dashboard/providers/Controllers.dart';
import 'package:flutter_admin_dashboard/providers/productsProvider.dart';
import 'package:provider/provider.dart';
import '../../../Global/Global.dart';
import '../../../Global/Widgets/labels/TextWidget.dart';

class AddDonation_POP extends StatefulWidget {
  const AddDonation_POP({super.key});

  @override
  State<AddDonation_POP> createState() => _AddDonation_POPState();
}

class _AddDonation_POPState extends State<AddDonation_POP> {
  String _errorText = '';

  void _validateInput(String value) {
    final RegExp integerRegex = RegExp(r'^[0-9]+$');

    setState(() {
      if (value.isEmpty) {
        _errorText = '';
      } else {
        if (!integerRegex.hasMatch(value)) {
          _errorText = 'Please enter a valid integer.';
        } else {
          _errorText = '';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Productprovider productprovider = context.read<Productprovider>();
    return SizedBox(
      width: MediaQuery.of(context).size.width > 500
          ? MediaQuery.of(context).size.width * 0.35
          : MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.width * 0.9,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            TextWidget(
              title: "Donor name:",
              txtSize: 25,
              txtColor: txtColor,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: MyTextField(
                  maxlines: 1,
                  obscureText: false,
                  controller: Controllers.donor_name_controller,
                  hintText: "M.Huzaifa"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextWidget(
              title: "Retail values:",
              txtSize: 25,
              txtColor: txtColor,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: MyTextField(
                maxlines: 1,
                obscureText: false,
                keytype: TextInputType.number,
                controller: Controllers.retailPrice,
                hintText: "6547",
                validateInput: _validateInput,
                errorText: _errorText,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextWidget(
              title: "Description:",
              txtSize: 25,
              txtColor: txtColor,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 250,
              child: MyTextField(
                maxlines: 10,
                obscureText: false,
                controller: Controllers.descriptionController,
                hintText: "Product Detail...",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
