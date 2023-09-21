import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/models/DetailModel.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import '../api/ApiHandler.dart';
import '../models/Product_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

class Productprovider extends ChangeNotifier {
  List<Product> products = [];
  bool isGettingProducts = true;
  Details? details;
  List<Product> filteredProducts = [];
  List<XFile> pickedFiles = [];
  getProducts() async {
    try {
      getDetailForAdmin();
      isGettingProducts = true;
      notifyListeners();
      var response = await Dio().get(getProduct);
      print(response);
      if (response.statusCode == 200) {
        products.clear();
        var data = jsonDecode(response.data);
        for (var element in data) {
          Product p = Product.fromMap(element);
          try {
            // var images = await FirebaseFirestore.instance
            //     .collection('ProductsImages')
            //     .where('Pid', isEqualTo: p.id)
            //     .get();
            // for (var element in images.docs) {
            //   p.images.add(element['url']);
            // }
          } catch (e) {
            SnackBar(content: Text(e.toString()));
          }
          products.add(p);
        }
        filteredProducts = products;
      }
    } catch (e) {
      print(e);
      SnackBar(content: Text(e.toString()));
    }
    isGettingProducts = false;
    notifyListeners();
  }

  addProduct(Product product, List<XFile> images) async {
    try {
      // var data = await FirebaseFirestore.instance
      //     .collection('Products')
      //     .add(product.toMap());
      FormData formData = FormData.fromMap(product.toMap());
      var data = await Dio().post(addProductIp,
          data: formData,
          options: Options(headers: {'Content-Type': 'application/json'}));
      if (data.statusCode == 200) {
        // EasyLoading.showToast('Product Saved Successfully!');
        var d = jsonDecode(data.data);
        for (XFile e in images) {
          try {
            // String filename = e.relativePath!.split('/').last;

            FormData imageFormData = FormData.fromMap({
              'pid': int.parse(d[0]),
              'image': base64Encode(await e.readAsBytes())
            });
            product.id = int.parse(d[0]);

            var res = await Dio().post(addProductImageIp,
                data: imageFormData,
                options:
                    Options(headers: {'Content-Type': 'multipart/form-data'}));
            if (res.statusCode == 200) {
              print(res.data);
              product.image_urls.add(res.data[0]);
            }
          } catch (e) {
            print(e);
          }
        }
        pickedFiles.clear();

        products.add(product);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  applyFilter({required String toFilter}) async {
    try {
      if (toFilter == 'All Items') {
        filteredProducts = products;
      } else {
        filteredProducts = products
            .where((element) =>
                element.productType.toLowerCase() ==
                toFilter.toLowerCase().split(' ')[0])
            .toList();
      }
      notifyListeners();
    } catch (e) {}
  }

  deleteProduct({required String id}) async {
    try {
      await FirebaseFirestore.instance.collection('Products').doc(id).delete();
      products.removeWhere((element) => element.id == id);
      notifyListeners();
    } catch (e) {}
  }

  updateProduct({required Product p}) async {
    try {
      var response =
          await Dio().post(updateProductApi, options: option, data: p.toJson());
      if (response.statusCode == 200) {
        int index = products.indexWhere((element) => element.id == p.id);
        products.removeAt(index);
        products.insert(index, p);
        notifyListeners();
      }
    } catch (e) {}
  }

  updateType({required String type, required int pid}) async {
    try {
      var response = await Dio().post(changeProductTypeIp,
          options: option,
          data: FormData.fromMap({'pid': pid, 'productType': type}));
      if (response.statusCode == 200) {
        int index = products.indexWhere((element) => element.id == pid);
        products[index].productType = type;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  getDetailForAdmin() async {
    try {
      var response = await Dio().get(getAdminDetail);
      if (response.statusCode == 200) {
        details = Details(
            auction_time: response.data['auction_time'],
            auctionCount: response.data['auction_count'],
            lastWeekSales: LastWeekSales(
                productCount: response.data['last_week_sales']['product_count'],
                totalPrice: response.data['last_week_sales']['total_price']),
            teleCount: response.data['tele_count'],
            totalProducts: response.data['total_products'],
            totalSales: response.data['total_sales']);
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  addAuctionTime(pid) async {
    try {
      var response =
          await Dio().get('$addTimerApi${DateTime.now().toString()}&pid=$pid');
      if (response.statusCode == 200) {}
      EasyLoading.showToast('Auction started');
    } catch (e) {
      print(e);
    }
  }
}
