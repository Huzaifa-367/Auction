import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/Global/Global.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/Image_Slider/Image_Slider.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/cards/dol_durma_clipper.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/cards/white_card.dart';
import 'package:flutter_admin_dashboard/models/Bidder_Model.dart';
import 'package:flutter_admin_dashboard/providers/BiddersProvider.dart';
import 'package:flutter_admin_dashboard/providers/productsProvider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_admin_dashboard/Global/Widgets/labels/TextWidget.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:provider/provider.dart';
import '../../../api/ApiHandler.dart';
import '../../../models/Product_Model.dart';
import 'GetSlideDownwidget.dart';

class PresenterView extends StatefulWidget {
  Product product;
  PresenterView({super.key, required this.product});

  @override
  State<PresenterView> createState() => _PresenterViewState();
}

const List<String> sampleImages = [];

class _PresenterViewState extends State<PresenterView> {
  @override
  void initState() {
    super.initState();

    bidderProvider ??= context.read<BidderProvider>();

    //bidderProvider!.getAuction();
    bidderProvider!.getBidders(widget.product.id);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    try {
      bidderProvider!.auctionTimer!.cancel();
      bidderProvider!.timer!.cancel();
    } catch (e) {}
    super.dispose();
  }

  late Productprovider productprovider;
  BidderProvider? bidderProvider;
  @override
  Widget build(BuildContext context) {
    bidderProvider ??= context.read<BidderProvider>();
    final size = MediaQuery.of(context).size;
    for (int i = 0; i < widget.product.image_urls.length; i++) {
      widget.product.image_urls[i] =
          productImageIp + widget.product.image_urls[i];
    }
    return SingleChildScrollView(
      //physics: const NeverScrollableScrollPhysics(),
      child: WhiteCard(
        // backicon: Icons.arrow_back_ios_new,
        // title: "Return",
        isbackpress: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Wrap(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: size.width >= 600
                      ? MediaQuery.of(context).size.width * 0.47
                      : MediaQuery.of(context).size.width * 0.9,
                  margin: const EdgeInsets.only(
                      top: 10, left: 12, right: 5, bottom: 5),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ListTile(
                              title: SizedBox(
                                width: double.infinity,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  child: Text(
                                    widget.product.name,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                              ),
                              subtitle: Text(
                                widget.product.donorName,
                                style: const TextStyle(
                                  fontSize: 17,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              leading: const CircleAvatar(
                                radius: 25,
                                backgroundColor: Color(0xFFE1E2E2),
                                child: CircleAvatar(
                                  radius: 23,
                                  backgroundImage: AssetImage(
                                    "assets/2m.jpg",
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8.0,
                              //left: 5.0,
                              right: 15.0,
                              child: SlideCountDownWidget(
                                product: widget.product,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: scfColor3,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 5,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    TextWidget(
                                      title: "Retail Value: £",
                                      txtSize: 17,
                                      txtColor: txtColor,
                                    ),
                                    TextWidget(
                                      title: widget.product.retailvalue,
                                      txtSize: 15,
                                      txtColor: txtColor,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Row(
                                  children: [
                                    TextWidget(
                                      title: "Lot Number: ",
                                      txtSize: 17,
                                      txtColor: txtColor,
                                    ),
                                    TextWidget(
                                      title: widget.product.lotNo,
                                      txtSize: 15,
                                      txtColor: txtColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            //alignment: Alignment.center,
                            height: widget.product.image_urls.isNotEmpty
                                ? MediaQuery.of(context).size.height * 0.7
                                : MediaQuery.of(context).size.height * 0.2,
                            //width: MediaQuery.of(context).size.width * 0.9,
                            margin: const EdgeInsets.only(
                                top: 10, left: 30, right: 30, bottom: 10),
                            decoration: BoxDecoration(
                              // color: scfColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(24)),
                              border: Border.all(
                                color: btnColor,
                              ),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: widget.product.image_urls.isNotEmpty
                                        ? MediaQuery.of(context).size.height *
                                            0.7
                                        : MediaQuery.of(context).size.height *
                                            0.18,
                                    child: ParallaxSwiper(
                                      images: widget.product.image_urls,
                                      dragToScroll: true,
                                      viewPortFraction: 0.85,
                                      padding: const EdgeInsets.all(16.0),
                                      parallaxFactor: 10.0,
                                      foregroundFadeEnabled: true,
                                      backgroundZoomEnabled: true,
                                    ),
                                  ),
                                  // FanCarouselImageSlider(
                                  //   initalPageIndex: 0,
                                  //   autoPlay: true,
                                  //   autoPlayInterval: const Duration(
                                  //     seconds: 5,
                                  //   ),
                                  //   isClickable: false,
                                  //   sliderHeight:
                                  //       MediaQuery.of(context).size.height *
                                  //           0.7,
                                  //   imagesLink: widget.product.image_urls,
                                  //   userCanDrag: true,
                                  //   isAssets: false,
                                  //   imageFitMode: BoxFit.fill,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          child: Text(
                            widget.product.description,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              // letterSpacing: 1.1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10,
                  ),
                  child: Material(
                    elevation: 5,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: SizedBox(
                        height: size.width >= 600
                            ? MediaQuery.of(context).size.height * 0.9
                            : MediaQuery.of(context).size.height * 0.9,
                        width: size.width >= 600
                            ? MediaQuery.of(context).size.width * 0.3
                            : MediaQuery.of(context).size.width * 0.9,
                        child: Consumer<BidderProvider>(
                          builder: (context, value, child) {
                            return value.isFirst && value.isGettingBidders
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : bidderProvider!.bidders.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            bidderProvider!.bidders.isNotEmpty
                                                ? bidderProvider!.bidders.length
                                                : 0,
                                        itemBuilder: (context, index) =>
                                            _getNewTaskTile(
                                                bidder: bidderProvider!
                                                    .bidders[index]),
                                      )
                                    : const Center(
                                        child: Text('No Bidders Found'),
                                      );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _getNewTaskTile({required Bidder bidder}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipPath(
            clipper: DolDurmaClipper(right: 40, holeRadius: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                color: bkColor,
              ),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text(
                            bidder.user_Name,
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        loggedinuser!.userType != "pres"
                            ? FittedBox(
                                child: Text(
                                  "Phone No. ${bidder.phoneNo}",
                                  style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                        fontSize: 15, color: Colors.black87),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(height: 12),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     const Icon(
                        //       Icons.access_time_rounded,
                        //       color: Colors.black87,
                        //       size: 18,
                        //     ),
                        //     // const SizedBox(width: 4),
                        //     // FittedBox(
                        //     //   child: Text(
                        //     //     "Date: 04-08-2023 - Time:09-23",
                        //     //     style: GoogleFonts.lato(
                        //     //       textStyle: const TextStyle(
                        //     //           fontSize: 13, color: Colors.black87),
                        //     //     ),
                        //     //   ),
                        //     // ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 3,
                    child: FittedBox(
                      child: Text(
                        "£: ${bidder.amount}",
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              fontSize: 15, color: Colors.black87),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
