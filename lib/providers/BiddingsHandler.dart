import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_admin_dashboard/models/Bidder_Model.dart';
import 'package:flutter_admin_dashboard/models/Product_Model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../api/ApiHandler.dart';

class BiddingHandler extends GetxController {
  List<Product> products = [];

  startListening() {
    try {
      _getTheLatestBid();
      Timer.periodic(const Duration(seconds: 2), (timer) {
        _getTheLatestBid();
      });
    } catch (e) {}
  }

  _getTheLatestBid() async {
    try {
      var res = await Dio().get(getLatestBid);
      if (res.statusCode == 200) {
        if (res.data != 'No results found') {
          Bidder bidder = Bidder.fromJson(res.data);
          print("_getTheLatestBid()===========> $bidder");
          EasyLoading.showToast(
              'new bidd from ${bidder.user_Name} on products ${bidder.product_id}');
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
