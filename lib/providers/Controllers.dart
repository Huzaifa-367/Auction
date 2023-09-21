import 'package:flutter/material.dart';

class Controllers {
//Products
  static TextEditingController p_name = TextEditingController();
  static TextEditingController descriptionController = TextEditingController();
  static TextEditingController donor_name_controller = TextEditingController();
  static TextEditingController retailPrice = TextEditingController();
  static TextEditingController lotnumber = TextEditingController();
  static TextEditingController qty = TextEditingController();
  static TextEditingController time = TextEditingController();

  static bool isLive = false;
  static bool isQuickSale = false;

  static clearproductControllers() {
    p_name.text = descriptionController.text = donor_name_controller.text =
        retailPrice.text = lotnumber.text = qty.text = '';
  }

//Biddings
  static TextEditingController item_name_controller = TextEditingController();
  static TextEditingController biddername = TextEditingController();
  static TextEditingController telephone = TextEditingController();
  static TextEditingController amount = TextEditingController();
  static clearbiddersControllers() {
    item_name_controller.text =
        biddername.text = telephone.text = amount.text = '';
  }

// Users
  static TextEditingController username = TextEditingController();
  static TextEditingController useremail = TextEditingController();
  static TextEditingController userpass = TextEditingController();
  static TextEditingController userrole = TextEditingController();
  static clearusersControllers() {
    username.text = useremail.text = userpass.text = userrole.text = '';
  }

  static TextEditingController timmer = TextEditingController();
  static clearTimmerControllers() {
    timmer.text = '';
  }
}
