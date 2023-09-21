import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/Global/Global.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/inputs/TextField_Round.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/labels/TextWidget.dart';
import 'package:flutter_admin_dashboard/providers/Controllers.dart';

class NewBidding_PopUp extends StatefulWidget {
  String? productName;

  NewBidding_PopUp({Key? key, required this.productName}) : super(key: key);

  @override
  State<NewBidding_PopUp> createState() => _NewBidding_PopUpState();
}

class _NewBidding_PopUpState extends State<NewBidding_PopUp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width > 500
            ? MediaQuery.of(context).size.width * 0.3
            : MediaQuery.of(context).size.width * 0.9,
        //height: 400,
        child: Column(
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  title: "Product Name:",
                  txtSize: 17,
                  txtColor: txtColor,
                ),
                TextWidget(
                  title: widget.productName!,
                  //title: product.retailvalue.toString(),
                  txtSize: 17,
                  txtColor: txtColor.withOpacity(.8),
                ),
              ],
            ),
            FittedBox(
              child: SizedBox(
                // width: MediaQuery.of(context).size.width * 0.6,
                width: 250,
                child: MyTextField(
                  controller: Controllers.biddername,
                  hintText: "Bidder name",
                  maxlines: 1,
                  obscureText: false,
                  keytype: TextInputType.name,
                  prefixIcon: const Icon(
                    Icons.person_2_rounded,
                  ),
                ),
              ),
            ),
            FittedBox(
              child: SizedBox(
                width: 250,
                child: MyTextField(
                  controller: Controllers.telephone,
                  hintText: "Telephone Number",
                  maxlines: 1,
                  obscureText: false,
                  keytype: TextInputType.name,
                  prefixIcon: const Icon(
                    Icons.phone,
                  ),
                ),
              ),
            ),
            FittedBox(
              child: SizedBox(
                width: 250,
                child: MyTextField(
                  controller: Controllers.amount,
                  hintText: "Amount",
                  maxlines: 1,
                  obscureText: false,
                  keytype: TextInputType.name,
                  prefixIcon: const Icon(
                    Icons.currency_pound_rounded,
                  ),
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
