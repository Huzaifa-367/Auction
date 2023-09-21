import 'package:flutter/widgets.dart';
import 'package:flutter_admin_dashboard/Global/Global.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/SnackBar/SnackBar.dart';
import 'package:flutter_admin_dashboard/api/ApiHandler.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../../Global/Widgets/buttons/ButtonWidget.dart';
import '../../../models/Product_Model.dart';
import '../../../providers/BiddersProvider.dart';
import '../../../providers/productsProvider.dart';

class SlideCountDownWidget extends StatefulWidget {
  Product product;
  SlideCountDownWidget({super.key, required this.product});

  @override
  State<SlideCountDownWidget> createState() => _SlideCountDownWidgetState();
}

class _SlideCountDownWidgetState extends State<SlideCountDownWidget> {
  late BidderProvider bidderProvider;
  bool isStarted = false;
  late Productprovider productprovider;
  @override
  Widget build(BuildContext context) {
    productprovider = context.read<Productprovider>();
    bidderProvider = context.read<BidderProvider>();
    return Row(
      children: [
        loggedinuser!.userType == "admin" && !isStarted
            ? ButtonWidget(
                btnText: "Start",
                onPress: () async {
                  setState(() {
                    isStarted = true;
                  });
                  productprovider.addAuctionTime(widget.product.id);
                  //bidderProvider.getAuctionDetail();
                })
            : const SizedBox.shrink(),
        context.watch<BidderProvider>().productId == widget.product.id ||
                isStarted
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: SlideCountdownSeparated(
                  onDone: () {
                    try {
                      String status = 'UnSold';
                      if (bidderProvider.bidders.isNotEmpty) {
                        saleToBidder(
                            bidderId: bidderProvider.bidders[0].id,
                            productId: widget.product.id);
                        if (bidderProvider.timer != null) {
                          bidderProvider.timer!.cancel();
                        }

                        status = 'Sold';
                        // EasyLoading.showToast(
                        //   'Sold to ${bidderProvider.bidders[0].user_Name}',
                        // );
                        snackBar(
                          context,
                          'Sold to ${bidderProvider.bidders[0].user_Name}',
                        );
                      }
                      productprovider.updateType(
                        type: status,
                        pid: widget.product.id,
                      );
                    } catch (e) {
                      String error = e.toString();
                      //print(e);
                    }
                    isStarted = false;
                  },
                  duration: Duration(
                      minutes: isStarted
                          ? widget.product.auctionTime
                          : bidderProvider.startedTime == null
                              ? 0
                              : (widget.product.auctionTime) -
                                          (bidderProvider.startedTime!) <
                                      widget.product.auctionTime
                                  ? (widget.product.auctionTime) -
                                      (bidderProvider.startedTime!)
                                  : 0),
                  separatorType: SeparatorType.symbol,
                  slideDirection: SlideDirection.up,
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
