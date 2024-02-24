import 'package:flutter/widgets.dart';
import 'package:flutter_admin_dashboard/Global/Global.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/SnackBar/SnackBar.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/labels/TextWidget.dart';
import 'package:flutter_admin_dashboard/api/ApiHandler.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../../Global/Widgets/buttons/ButtonWidget.dart';
import '../../../models/Product_Model.dart';
import '../../../providers/BiddersProvider.dart';
import '../../../providers/productsProvider.dart';
/////
///
///
///
///
import 'dart:async';
import 'package:flutter/material.dart';

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

  Duration duration = const Duration();
  Timer? timer;

  bool countDown = true;

  @override
  void initState() {
    super.initState();
    bidderProvider = context.read<BidderProvider>();
    bidderProvider.auctionTime = widget.product.auctionTime;
    bidderProvider.pid = widget.product.id;
    startTimer();
  }

  void reset() {
    if (countDown) {
      setState(() => bidderProvider.duration = const Duration());
    } else {
      setState(() => bidderProvider.duration = const Duration());
    }
  }

  void startTimer() {
    if (timer != null) {
      timer!.cancel();
    }

    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final addSeconds = countDown ? -1 : 1;
    setState(() {
      final seconds = bidderProvider.duration!.inSeconds + addSeconds;
      // if (seconds <= 0) {
      //   timer?.cancel();
      //   if (seconds == 1) {
      //     try {
      //       //String status = 'UnSold';
      //       if (bidderProvider.bidders.isNotEmpty) {
      //         saleToBidder(
      //             bidderId: bidderProvider.bidders[0].id,
      //             productId: widget.product.id);
      //         if (bidderProvider.timer != null) {
      //           bidderProvider.timer!.cancel();
      //         }
      //         productprovider.updateType(
      //           type: 'Sold',
      //           pid: widget.product.id,
      //         );
      //         snackBar(context,
      //             'Sold to ${bidderProvider.bidders[0].user_Name}', null);
      //       } else {
      //         productprovider.updateType(
      //           type: 'UnSold',
      //           pid: widget.product.id,
      //         );
      //         snackBar(context, 'Item set to UnSold.', null);
      //       }
      //     } catch (e) {
      //       //String error = e.toString();
      //     }
      //   }
      // } else {
      bidderProvider.duration = Duration(seconds: seconds);
      // }
    });
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) {
    productprovider = context.read<Productprovider>();
    bidderProvider = context.read<BidderProvider>();
    return Row(
      children: [
        // loggedinuser!.userType == "admin" &&
        //         ((Duration(minutes: widget.product.auctionTime) -
        //                     Duration(seconds: bidderProvider.startedTime ?? 0))
        //                 .inSeconds >
        //             0)
        //     ? ButtonWidget(
        //         btnText: "Start",
        //         onPress: () async {
        //           setState(() {
        //             isStarted = true;
        //           });
        //           productprovider.addAuctionTime(widget.product.id);
        //           //bidderProvider.getAuctionDetail();
        //         })
        //     : const SizedBox.shrink(),
        // Padding(
        //   padding: const EdgeInsets.symmetric(
        //     horizontal: 8.0,
        //   ),
        //   child: SlideCountdownSeparated(
        //     onDone: () {
        //       try {
        //         String status = 'UnSold';
        //         if (bidderProvider.bidders.isNotEmpty) {
        //           saleToBidder(
        //               bidderId: bidderProvider.bidders[0].id,
        //               productId: widget.product.id);
        //           if (bidderProvider.timer != null) {
        //             bidderProvider.timer!.cancel();
        //           }

        //           status = 'Sold';
        //           // EasyLoading.showToast(
        //           //   'Sold to ${bidderProvider.bidders[0].user_Name}',
        //           // );
        //           snackBar(
        //             context,
        //             'Sold to ${bidderProvider.bidders[0].user_Name}',
        //           );
        //         }
        //         productprovider.updateType(
        //           type: status,
        //           pid: widget.product.id,
        //         );
        //       } catch (e) {
        //         String error = e.toString();
        //         //print(e);
        //       }
        //       isStarted = false;
        //     },
        //     duration: Duration(minutes: widget.product.auctionTime) -
        //         Duration(
        //             seconds: context.watch<BidderProvider>().startedTime ?? 0),

        //     //  Duration(
        //     //     seconds:

        //     //     // minutes: isStarted
        //     //     //     ? widget.product.auctionTime
        //     //     //     : bidderProvider.startedTime == null
        //     //     //         ? 0
        //     //     //         : (widget.product.auctionTime) -
        //     //     //                     (bidderProvider.startedTime!) <
        //     //     //                 widget.product.auctionTime
        //     //     //             ? (widget.product.auctionTime) -
        //     //     //                 (bidderProvider.startedTime!)
        //     //     //             : 0
        //     //     ),
        //     separatorType: SeparatorType.symbol,
        //     slideDirection: SlideDirection.up,
        //   ),
        // )

        (loggedinuser!.userType == "admin" && !isStarted) &&
                (widget.product.productType == "Auction" ||
                    widget.product.productType == "Quick")
            ? Row(
                children: [buildButtons()],
              )
            : const SizedBox.shrink(),
        context.watch<BidderProvider>().productId == widget.product.id ||
                isStarted
            ? Row(
                children: [
                  buildTime(),
                ],
              )
            : const SizedBox.shrink()
      ],
    );
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    //final hours = twoDigits(bidderProvider.duration!.inHours);
    final minutes = twoDigits(bidderProvider.duration!.inMinutes.remainder(60));
    final seconds = twoDigits(bidderProvider.duration!.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //buildTimeCard(time: hours, header: 'Hr'),
        buildTimeCard(time: minutes, header: 'Min'),
        buildTimeCard(time: seconds, header: 'Sec'),
      ],
    );
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Text(
                time,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
            Text(
              header,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 10,
              ),
            ),
          ],
        ),
      );

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;
    return !isRunning
        ? TextButton(
            onPressed: () {
              bidderProvider.duration =
                  Duration(minutes: widget.product.auctionTime);
              productprovider.addAuctionTime(widget.product.id);
              startTimer();
            },
            child: Container(
              decoration: BoxDecoration(
                color: btnColor,
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 10,
              ),
              child: const TextWidget(
                title: "Start",
                txtSize: 15,
                txtColor: Colors.white,
              ),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (isRunning) {
                      try {
                        //String status = 'UnSold';
                        if (bidderProvider.bidders.isNotEmpty) {
                          saleToBidder(
                              bidderId: bidderProvider.bidders[0].id,
                              productId: widget.product.id);
                          if (bidderProvider.timer != null) {
                            bidderProvider.timer!.cancel();
                          }
                          productprovider.updateType(
                            type: 'Sold',
                            pid: widget.product.id,
                          );
                          snackBar(
                              context,
                              'Sold to ${bidderProvider.bidders[0].user_Name}',
                              null);
                        } else {
                          productprovider.updateType(
                            type: 'UnSold',
                            pid: widget.product.id,
                          );
                          snackBar(context, 'Item set to UnSold.', null);
                        }
                      } catch (e) {
                        String error = e.toString();
                        print(error);
                      }
                      stopTimer(resets: false);
                    }
                  });
                  bidderProvider.duration = const Duration();
                  productprovider.addAuctionTime(-1);
                },
                child: const Text("Stop"),
              ),
              // const SizedBox(
              //   width: 12,
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     setState(() {
              //       stopTimer();
              //     });
              //   },
              //   child: const Text("Cancel"),
              // ),
            ],
          );
  }
}
