import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_admin_dashboard/models/Bidder_Model.dart';
import 'package:flutter_admin_dashboard/models/Product_Model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../api/ApiHandler.dart';

class BiddingHandler extends GetxController {
  List<Product> products = [];

  _getTheLatestBid() async {
    try {
      var res = await Dio().get(getLatestBid);
      if (res.statusCode == 200) {
        if (res.data != 'No results found') {
          Bidder bidder = Bidder.fromJson(res.data);
          EasyLoading.showToast(
              'new bidd is here from ${bidder.user_Name} on products ${bidder.product_id}');
        }
      }
    } catch (e) {}
  }

  startListening() {
    try {
      _getTheLatestBid();
      Timer.periodic(const Duration(seconds: 5), (timer) {
        _getTheLatestBid();
      });
    } catch (e) {}
  }
}
