import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/buttons/ButtonWidget.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/inputs/TextField_Round.dart';
import 'package:flutter_admin_dashboard/Global/constants.dart';
import 'package:flutter_admin_dashboard/providers/Controllers.dart';
import 'package:flutter_admin_dashboard/providers/productsProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../Global/Global.dart';
import '../../../Global/Widgets/labels/TextWidget.dart';

class AddProduct_POP extends StatefulWidget {
  const AddProduct_POP({super.key});

  @override
  State<AddProduct_POP> createState() => _AddProduct_POPState();
}

class _AddProduct_POPState extends State<AddProduct_POP> {
  String _errorText = '';
  String _errorText2 = '';

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

  void _validatestringInput(String value) {
    final RegExp singleQuoteRegex = RegExp(r"'");

    setState(() {
      if (value.isEmpty) {
        _errorText2 = '';
      } else {
        if (singleQuoteRegex.hasMatch(value)) {
          _errorText2 = "String shouldn't contain a single quote(').";
        } else {
          _errorText2 = '';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Productprovider productprovider = context.read<Productprovider>();
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
              title: "Item Name:",
              txtSize: 25,
              txtColor: txtColor,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: MyTextField(
                maxlines: 1,
                obscureText: false,
                controller: Controllers.p_name,
                hintText: "Taxi / Boat",
                validateInput: _validatestringInput,
                errorText: _errorText2,
              ),
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
                hintText: "012",
                validateInput: _validateInput,
                errorText: _errorText,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextWidget(
              title: "Item Qty:",
              txtSize: 25,
              txtColor: txtColor,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: MyTextField(
                maxlines: 1,
                obscureText: false,
                controller: Controllers.qty,
                hintText: "Enter Quantity of item.",
                validateInput: _validateInput,
                errorText: _errorText,
              ),
            ),
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
                hintText: "M.Huzaifa",
                validateInput: _validatestringInput,
                errorText: _errorText2,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextWidget(
              title: "lot number:",
              txtSize: 25,
              txtColor: txtColor,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: MyTextField(
                  maxlines: 1,
                  obscureText: false,
                  controller: Controllers.lotnumber,
                  validateInput: _validateInput,
                  hintText: "65A4F7"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextWidget(
              title: "Auction Time:",
              txtSize: 25,
              txtColor: txtColor,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: MyTextField(
                maxlines: 1,
                obscureText: false,
                controller: Controllers.timmer,
                hintText: "Time In Minutes: 10 ",
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
                validateInput: _validatestringInput,
                errorText: _errorText2,
              ),
            ),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width > 500
                  ? MediaQuery.of(context).size.width * 0.35
                  : MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: btnColor,
                ),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: context.watch<Productprovider>().pickedFiles.length,
                itemBuilder: (context, index) => FutureBuilder(
                  future: productprovider.pickedFiles[index].readAsBytes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Icon(Icons.error);
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.memory(
                            snapshot.data!,
                            fit: BoxFit.fill,
                            height: 200,
                            width: 170,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ButtonWidget(
                  btnText: "Pick Image",
                  onPress: () async {
                    await pickImage(
                        source: ImageSource.gallery,
                        productprovier: productprovider);
                  },
                ),
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
