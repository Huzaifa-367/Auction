import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/api/ApiHandler.dart';
import 'package:flutter_admin_dashboard/models/Bidder_Model.dart';

import '../models/Product_Model.dart';

class BidderProvider extends ChangeNotifier {
  List<Bidder> bidders = [];
  bool isBidderRunning = false;
  bool isGettingProducts = false;
  Timer? timer;
  Timer? auctionTimer;
  bool isGettingBidders = false;
  int currentIndex = 0;
  bool isFirst = true;

  int? startedTime;
  int? productId;

  getAuction() async {
    try {
      await getAuctionDetail();
      auctionTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
        try {
          getAuctionDetail();
        } catch (w) {}
      });
    } catch (e) {}
  }

  setInitial() {
    try {
      if (timer != null) {
        timer!.cancel();
      }
      if (auctionTimer != null) {
        auctionTimer!.cancel();
      }
      startedTime = null;
      productId = null;
    } catch (e) {}
  }

  getAuctionDetail() async {
    try {
      var response = await Dio().get(getAuctionDetailApi);
      if (response.statusCode == 200) {
        int idd = int.parse(response.data['pid']);

        productId = idd;
        var d = DateTime.now()
            .difference(DateTime.parse(response.data['dateTime']));
        startedTime = d.inMinutes;

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  getBidders(int pid) async {
    try {
      isBidderRunning = true;
      isGettingBidders = true;
      bidders.clear();
      notifyListeners();
      await getBidderapiCall(pid);
      isGettingBidders = false;

      isFirst = false;

      notifyListeners();
      timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
        try {
          print('get Bidder called');

          await getBidderapiCall(pid);
          notifyListeners();
        } catch (e) {
          print(e);
        }
      });
    } catch (e) {}
  }

  getBidderapiCall(int pid) async {
    try {
      var response = await Dio().get(getBiddersIp + pid.toString());
      if (response.statusCode == 200) {
        bidders.clear();
        //var data = jsonDecode(response.data);
        for (var element in response.data) {
          //print(jsonDecode(element));
          print(element as Map<String, dynamic>);
          print((element)['product_id']);
          bidders.add(Bidder.fromMap(element));

          //print(bidders);
        }
        bidders.sort(((a, b) => b.amount.compareTo(a.amount)));
      }
    } catch (e) {}
  }

  addBidder({required Bidder bidder}) async {
    try {
      FormData formData = FormData.fromMap(bidder.toMap());
      var response =
          await Dio().post(addBiddersIp, data: formData, options: option);
      if (response.statusCode == 200) {
        print(response.data);
      }
    } catch (e) {
      print(e);
    }
  }

  List<Product> products = [];
  getProductByType({required String productType}) async {
    try {
      isGettingProducts = true;
      notifyListeners();
      var response = await Dio().get(getProductByTypeIp);
      print(response);
      if (response.statusCode == 200) {
        products.clear();
        var data = jsonDecode(response.data);
        for (var element in data) {
          Product p = Product.fromMap(element);
          try {} catch (e) {}
          products.add(p);
        }
      }
    } catch (e) {
      print(e);
    }
    isGettingProducts = false;
    notifyListeners();
  }
}
