import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

String ip = 'https://php.cozyreach.com/';
String productImageIp = '${ip}uploads/';
String userLoginAPi = '${ip}UserLogin.php';
String signUpAPi = '${ip}create_api.php';
String updateProductApi = '${ip}UpdateProductApi.php';
String updateVisibleApi = '${ip}UpdateVisibleApi.php';
String getAdminDetail = '${ip}getDetailForAdminApi.php';
Options option = Options(headers: {'Content-Type': 'application/json'});
String addProductIp = '${ip}AddproductApi.php';
String addDonationIp = '${ip}addDonationApi.php';
String getDonationAmountIp = '${ip}GetDonationAmountApi.php';
String getDonationsip = '${ip}getDonationsApi.php';

String addProductImageIp = '${ip}addProductImage.php';
String getProduct = '${ip}getapi.php';
String getProductByTypeIp = '${ip}GetProductByType.php';
String changeProductTypeIp = '${ip}changeProductType.php';
String getLatestBid = '${ip}GetLatestBiddApi.php';

String getBiddersIp = '${ip}getBidders.php?product_id=';
String getheighestBiddersIp = '${ip}GetHeighestBidderApi.php?product_id=';
String addBiddersIp = '${ip}addBidder.php';
String addTimerApi = '${ip}AddAuctionStartTime.php?time=';
String getAuctionDetailApi = '${ip}GetAuctionTimer.php';
String addBidder = '';
String addSalesApi = '${ip}AddSaleApi.php?';
String getBidder = '';

saleToBidder({required int bidderId, required int productId}) async {
  try {
    String ippp =
        '${addSalesApi}pid=$productId&date=${DateTime.now().toString()}&bidderId=$bidderId';
    var res = await Dio().get(ippp);
    if (res.statusCode == 200) {
      EasyLoading.showToast('Sold successfully!');
    }
  } catch (e) {}
}
