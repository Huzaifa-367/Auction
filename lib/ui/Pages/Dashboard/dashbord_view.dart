import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/Global/Global.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/SnackBar/SnackBar.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/cards/white_card.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/labels/TextWidget.dart';
import 'package:flutter_admin_dashboard/providers/side_menu_provider.dart';
import 'package:flutter_admin_dashboard/services/navigation_service.dart';
import 'package:flutter_admin_dashboard/ui/Pages/Dashboard/Presenter_Screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../api/ApiHandler.dart';
import '../../../providers/productsProvider.dart';
//
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  void navigateTo(String routeName) {
    NavigationService.navigateTo(routeName);
    SideMenuProvider.closeMenu();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productprovider ??= context.read<Productprovider>();
    productprovider!.getProducts();
  }

  Productprovider? productprovider;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          topbox(size),
          products(),
        ],
      ),
    );
  }

  Widget topbox(var size) {
    return WhiteCard(
      width: size.width * 0.9,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Consumer<Productprovider>(
            builder: (context, value, child) => Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Material(
                    elevation: 10,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      height: size.width >= 600
                          ? size.height * 0.25
                          : size.height * 0.19,
                      width: size.width >= 600
                          ? size.width * 0.2
                          : size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          stops: const [0.1, 0.9],
                          colors: [scfColor3, scfColor2],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Text(
                                productprovider!.details != null
                                    ? '£:${productprovider!.details!.lastWeekSales!.totalPrice ?? ''}'
                                    : '£: 0',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.merge(
                                      TextStyle(
                                        color: txtColor,
                                        fontFamily: GoogleFonts.jetBrainsMono()
                                            .fontFamily,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                //overflow: decorationClipBehavior,
                              ),
                            ),
                            FittedBox(
                              child: Text(
                                "Amount Collected",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.apply(
                                      color: txtColor.withOpacity(0.9),
                                    ),
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        "Sold In Current Auction",
                                        // style: Theme.of(context)
                                        //     .textTheme
                                        //     .bodyLarge
                                        //     ?.apply(
                                        //         color: txtColor.withOpacity(1),
                                        //         fontWeightDelta: 2),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.apply(
                                              color: txtColor.withOpacity(0.9),
                                            ),
                                      ),
                                    ),
                                    Text(
                                      productprovider!.details != null
                                          ? productprovider!
                                                  .details!
                                                  .lastWeekSales!
                                                  .productCount ??
                                              ''
                                          : '0',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.apply(
                                              color: txtColor.withOpacity(0.9),
                                              fontWeightDelta: 2),
                                    ),
                                  ],
                                ),
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                const FittedBox(
                                  child: ImageIcon(
                                    AssetImage(
                                      "assets/auction.png",
                                    ),
                                    color: Colors.black,
                                    size: 45,
                                  ),
                                ),
                              ],
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Material(
                    elevation: 10,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      height: size.width >= 600
                          ? size.height * 0.25
                          : size.height * 0.19,
                      width: size.width >= 600
                          ? size.width * 0.2
                          : size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          stops: const [0.1, 0.9],
                          colors: [scfColor3, scfColor2],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productprovider!.details != null
                                  ? productprovider!.details!.totalProducts ??
                                      ''
                                  : '0',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.merge(
                                    TextStyle(
                                      color: txtColor,
                                      fontFamily: GoogleFonts.jetBrainsMono()
                                          .fontFamily,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                              //overflow: decorationClipBehavior,
                            ),
                            Text(
                              "Total Products",
                              style:
                                  Theme.of(context).textTheme.bodyMedium?.apply(
                                        color: txtColor.withOpacity(0.9),
                                      ),
                            ),
                            const Expanded(child: SizedBox()),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Sold",
                                      // style: Theme.of(context)
                                      //     .textTheme
                                      //     .bodyLarge
                                      //     ?.apply(
                                      //         color: txtColor.withOpacity(1),
                                      //         fontWeightDelta: 2),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.apply(
                                            color: txtColor.withOpacity(0.9),
                                          ),
                                    ),
                                    Text(
                                      productprovider!.details != null
                                          ? productprovider!
                                                  .details!.totalSales ??
                                              ''
                                          : '0',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.apply(
                                              color: txtColor.withOpacity(0.9),
                                              fontWeightDelta: 2),
                                    ),
                                  ],
                                ),
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                const ImageIcon(
                                  AssetImage(
                                    "assets/sold.png",
                                  ),
                                  color: Colors.black,
                                  size: 45,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Material(
                    elevation: 10,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      height: size.width >= 600
                          ? size.height * 0.25
                          : size.height * 0.19,
                      width: size.width >= 600
                          ? size.width * 0.2
                          : size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          stops: const [0.1, 0.9],
                          colors: [scfColor3, scfColor2],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productprovider!.details != null
                                  ? productprovider!.details!.teleCount ?? ''
                                  : '0',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.merge(
                                    TextStyle(
                                      color: txtColor,
                                      fontFamily: GoogleFonts.jetBrainsMono()
                                          .fontFamily,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                              //overflow: decorationClipBehavior,
                            ),
                            Text(
                              "Telephonists",
                              style:
                                  Theme.of(context).textTheme.bodyMedium?.apply(
                                        color: txtColor.withOpacity(0.9),
                                      ),
                            ),
                            const Expanded(child: SizedBox()),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Products At Auction",
                                      // style: Theme.of(context)
                                      //     .textTheme
                                      //     .bodyLarge
                                      //     ?.apply(
                                      //         color: txtColor.withOpacity(1),
                                      //         fontWeightDelta: 2),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.apply(
                                            color: txtColor.withOpacity(0.9),
                                          ),
                                    ),
                                    Text(
                                      productprovider!.details != null
                                          ? productprovider!
                                                  .details!.auctionCount ??
                                              ''
                                          : '0',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.apply(
                                              color: txtColor.withOpacity(0.9),
                                              fontWeightDelta: 2),
                                    ),
                                  ],
                                ),
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                const ImageIcon(
                                  AssetImage(
                                    "assets/auction.png",
                                  ),
                                  color: Colors.red,
                                  size: 45,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 15,
                //     vertical: 10,
                //   ),
                //   child: Material(
                //     elevation: 10,
                //     borderRadius: const BorderRadius.all(
                //       Radius.circular(20),
                //     ),
                //     child: Container(
                //       height: size.width >= 600
                //           ? size.height * 0.25
                //           : size.height * 0.17,
                //       width: size.width >= 600
                //           ? size.width * 0.12
                //           : size.width * 0.8,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(18),
                //         gradient: LinearGradient(
                //           begin: Alignment.centerLeft,
                //           stops: const [0.1, 0.9],
                //           colors: [scfColor3, scfColor2],
                //         ),
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.symmetric(
                //           horizontal: 20,
                //           vertical: 20,
                //         ),
                //         child: Column(
                //           //crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             SlideCountdownSeparated(
                //               onDone: () async {
                //                 // await productprovider.updateType(
                //                 //     type: 'gen', pid: widget.product.id);
                //               },
                //               duration: const Duration(minutes: 15),
                //               separatorType: SeparatorType.symbol,
                //               separatorStyle: TextStyle(
                //                 // Use a default TextStyle if headline6 is null
                //                 color: txtColor,
                //                 fontFamily: GoogleFonts.jetBrainsMono()
                //                     .fontFamily,
                //                 fontWeight: FontWeight.w700,
                //                 fontSize: 20, // Use a default font size
                //               ),
                //               slideDirection: SlideDirection.up,
                //               height: 40,
                //               width: 30,
                //               textStyle: Theme.of(context)
                //                       .textTheme
                //                       .titleLarge
                //                       ?.copyWith(
                //                         color: txtColor,
                //                         fontFamily:
                //                             GoogleFonts.jetBrainsMono()
                //                                 .fontFamily,
                //                         fontWeight: FontWeight.w700,
                //                       ) ??
                //                   TextStyle(
                //                     // Use a default TextStyle if headline6 is null
                //                     color: txtColor,
                //                     fontFamily:
                //                         GoogleFonts.jetBrainsMono()
                //                             .fontFamily,
                //                     fontWeight: FontWeight.w700,
                //                     fontSize:
                //                         20, // Use a default font size
                //                   ),
                //             ),
                //             const SizedBox(
                //               height: 10,
                //             ),
                //             Text(
                //               "Time Left",
                //               style: Theme.of(context)
                //                   .textTheme
                //                   .bodyLarge
                //                   ?.merge(
                //                     TextStyle(
                //                       color: txtColor,
                //                       fontFamily:
                //                           GoogleFonts.jetBrainsMono()
                //                               .fontFamily,
                //                       fontWeight: FontWeight.w700,
                //                     ),
                //                   ),
                //             ),
                //             FittedBox(
                //               child: ButtonWidget(
                //                 btnText: "Start Auction",
                //                 onPress: () {
                //                   //  productprovider!.addAuctionTime();
                //                   // NotificationsService.showSnackBar(
                //                   //   "Auction has been started",
                //                   // );
                //                 },
                //               ),
                //             ),
                //             const SizedBox(
                //               height: 4,
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          )),
    );
  }

  Widget products() {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(height: 15),
        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 25),
        //   alignment: Alignment.centerLeft,
        //   child: const Text(
        //     "Products",
        //     style: TextStyle(
        //       fontSize: 24,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        Consumer<Productprovider>(
          builder: (context, value, child) => value.isGettingProducts
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : value.filteredProducts.isEmpty
                  ? const Center(
                      child: Text('no products found!'),
                    )
                  : StaggeredGrid.count(
                      crossAxisCount: size.width >= 600 ? 3 : 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      axisDirection: AxisDirection.down,
                      children: [
                        ...List.generate(
                          productprovider!.filteredProducts.length,
                          (index) {
                            final product =
                                productprovider!.filteredProducts[index];
                            return (product.productType == "Auction" ||
                                    product.productType == "Quick") &&
                                        loggedinuser!.userType == "pres"
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PresenterView(
                                              product: product,
                                            ),
                                          ));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        top: 10,
                                        left: 12,
                                        right: 5,
                                        bottom: 5,
                                      ),
                                      child: Material(
                                        elevation: 10,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: product.productType ==
                                                    "Auction"
                                                ? const Color.fromARGB(
                                                    255, 252, 233, 220)
                                                : product.productType == "Quick"
                                                    ? const Color.fromARGB(
                                                        255, 221, 243, 175)
                                                    : product.productType ==
                                                                "Sold" &&
                                                            loggedinuser!
                                                                    .userType !=
                                                                "tele"
                                                        ? const Color.fromARGB(
                                                            146, 187, 250, 246)
                                                        : Colors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 80.0,
                                                //width: 200.0,
                                                child: Stack(
                                                  children: [
                                                    ListTile(
                                                      title: SizedBox(
                                                        width: double.infinity,
                                                        child:
                                                            SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          physics:
                                                              const BouncingScrollPhysics(),
                                                          child: Text(
                                                            product.name,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              letterSpacing:
                                                                  1.2,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      subtitle: Text(
                                                        product.donorName,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          letterSpacing: 1.2,
                                                        ),
                                                      ),
                                                      leading:
                                                          const CircleAvatar(
                                                        radius: 25,
                                                        backgroundColor:
                                                            Color(0xFFE1E2E2),
                                                        child: CircleAvatar(
                                                          radius: 23,
                                                          backgroundImage:
                                                              AssetImage(
                                                            "assets/2m.jpg",
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // loggedinuser!.userType == "admin"
                                                    //     ? Positioned(
                                                    //         top: 5,
                                                    //         right: 5,
                                                    //         child: IconButton(
                                                    //           onPressed: () {
                                                    //             //

                                                    //             //
                                                    //           },
                                                    //           icon: const ImageIcon(
                                                    //             AssetImage(
                                                    //               "assets/edit.png",
                                                    //             ),
                                                    //             color: Colors.black,
                                                    //             size: 25,
                                                    //           ),
                                                    //         ),
                                                    //       )
                                                    //     : const SizedBox(),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                TextWidget(
                                                                  title:
                                                                      "Retail Value: £",
                                                                  txtSize: 12,
                                                                  txtColor:
                                                                      txtColor,
                                                                ),
                                                                TextWidget(
                                                                  title: product
                                                                      .retailvalue
                                                                      .toString(),
                                                                  txtSize: 12,
                                                                  txtColor: txtColor
                                                                      .withOpacity(
                                                                          .8),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                TextWidget(
                                                                  title:
                                                                      "Lot Number: ",
                                                                  txtSize: 12,
                                                                  txtColor:
                                                                      txtColor,
                                                                ),
                                                                TextWidget(
                                                                  title: product
                                                                      .lotNo,
                                                                  txtSize: 12,
                                                                  txtColor: txtColor
                                                                      .withOpacity(
                                                                          .8),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        product.productType ==
                                                                "Sold"
                                                            ? const ImageIcon(
                                                                AssetImage(
                                                                  "assets/sold.png",
                                                                ),
                                                                color:
                                                                    Colors.red,
                                                                size: 40,
                                                              )
                                                            : product.productType ==
                                                                    "UnSold"
                                                                ? IconButton(
                                                                    onPressed:
                                                                        () async {
                                                                      await productprovider!.updateType(
                                                                          type:
                                                                              'gen',
                                                                          pid: product
                                                                              .id);
                                                                      snackBar(
                                                                          context,
                                                                          "Item updated for reselling.");
                                                                    },
                                                                    icon:
                                                                        const ImageIcon(
                                                                      AssetImage(
                                                                        "assets/resell.png",
                                                                      ),
                                                                      color: Colors
                                                                          .greenAccent,
                                                                      size: 40,
                                                                    ),
                                                                  )
                                                                : const SizedBox(),
                                                      ],
                                                    ),
                                                    product.productType ==
                                                            "UnSold"
                                                        ? Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              vertical: 10,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: scfColor3,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal:
                                                                    10.0,
                                                                vertical: 5,
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  TextWidget(
                                                                    title:
                                                                        "Last Auctioned At: ",
                                                                    txtSize: 12,
                                                                    txtColor:
                                                                        txtColor,
                                                                  ),
                                                                  TextWidget(
                                                                    title:
                                                                        "11:15 on 02/12/2023",
                                                                    txtSize: 12,
                                                                    txtColor: txtColor
                                                                        .withOpacity(
                                                                            .8),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        : product.productType ==
                                                                "Sold"
                                                            ? Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      scfColor3,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                ),
                                                                margin:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  vertical: 10,
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                    horizontal:
                                                                        10.0,
                                                                    vertical: 5,
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      TextWidget(
                                                                        title:
                                                                            "Item Sold At: £",
                                                                        txtSize:
                                                                            12,
                                                                        txtColor:
                                                                            txtColor,
                                                                      ),
                                                                      TextWidget(
                                                                        title:
                                                                            "3458",
                                                                        txtSize:
                                                                            12,
                                                                        txtColor:
                                                                            txtColor.withOpacity(.8),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            : const SizedBox(),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: product
                                                        .image_urls.isNotEmpty
                                                    ? 200
                                                    : 40,
                                                margin: const EdgeInsets.only(
                                                  top: 10,
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 0,
                                                ),
                                                child: product
                                                        .image_urls.isNotEmpty
                                                    ? Image.network(
                                                        productImageIp +
                                                            product.image_urls
                                                                .first,
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context,
                                                                error,
                                                                stackTrace) =>
                                                            const Icon(
                                                                Icons.error),
                                                      )
                                                    : const Text(
                                                        'Image not available'),
                                              ),
                                              loggedinuser!.userType == "admin"
                                                  ? Container(
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 12),
                                                      child: product.productType ==
                                                                  "Sold" ||
                                                              product.productType ==
                                                                  "UnSold"
                                                          ? const SizedBox()
                                                          : Row(
                                                              children: [
                                                                product.productType ==
                                                                        "Auction"
                                                                    ? IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          //

                                                                          //
                                                                        },
                                                                        icon:
                                                                            const ImageIcon(
                                                                          AssetImage(
                                                                            "assets/auction.png",
                                                                          ),
                                                                          color:
                                                                              Colors.red,
                                                                          size:
                                                                              35,
                                                                        ),
                                                                      )
                                                                    : IconButton(
                                                                        onPressed:
                                                                            () async {
                                                                          await productprovider!.updateType(
                                                                              type: 'Auction',
                                                                              pid: product.id);
                                                                          // ignore: use_build_context_synchronously
                                                                          snackBar(
                                                                            context,
                                                                            "Item set to Auction",
                                                                          );
                                                                          //
                                                                        },
                                                                        icon:
                                                                            ImageIcon(
                                                                          const AssetImage(
                                                                            "assets/auction.png",
                                                                          ),
                                                                          color: product.productType == "Auction"
                                                                              ? Colors.redAccent
                                                                              : Colors.black,
                                                                          size:
                                                                              35,
                                                                        ),
                                                                      ),
                                                                const Spacer(),
                                                                IconButton(
                                                                  onPressed:
                                                                      () async {
                                                                    await productprovider!.updateType(
                                                                        type:
                                                                            'Quick',
                                                                        pid: product
                                                                            .id);
                                                                    // ignore: use_build_context_synchronously
                                                                    snackBar(
                                                                      context,
                                                                      "Item set to Quick Sale",
                                                                    );
                                                                    //
                                                                  },
                                                                  icon:
                                                                      ImageIcon(
                                                                    const AssetImage(
                                                                      "assets/sale.png",
                                                                    ),
                                                                    color: product.productType ==
                                                                            "Quick"
                                                                        ? Colors
                                                                            .greenAccent
                                                                        : Colors
                                                                            .black,
                                                                    size: 35,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                    )
                                                  : const SizedBox.shrink(),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 10,
                                                ),
                                                child: Text(
                                                  product.description,
                                                  maxLines: 4,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    // letterSpacing: 1.1,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : loggedinuser!.userType == "admin"
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PresenterView(
                                                  product: product,
                                                ),
                                              ));
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            top: 10,
                                            left: 12,
                                            right: 5,
                                            bottom: 5,
                                          ),
                                          child: Material(
                                            elevation: 10,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: product.productType ==
                                                        "Auction"
                                                    ? const Color.fromARGB(
                                                        255, 252, 233, 220)
                                                    : product.productType ==
                                                            "Quick"
                                                        ? const Color.fromARGB(
                                                            255, 221, 243, 175)
                                                        : product.productType ==
                                                                    "Sold" &&
                                                                loggedinuser!
                                                                        .userType !=
                                                                    "tele"
                                                            ? const Color
                                                                    .fromARGB(
                                                                146,
                                                                187,
                                                                250,
                                                                246)
                                                            : Colors.white,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 80.0,
                                                    //width: 200.0,
                                                    child: Stack(
                                                      children: [
                                                        ListTile(
                                                          title: SizedBox(
                                                            width:
                                                                double.infinity,
                                                            child:
                                                                SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              physics:
                                                                  const BouncingScrollPhysics(),
                                                              child: Text(
                                                                product.name,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  letterSpacing:
                                                                      1.2,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          subtitle: Text(
                                                            product.donorName,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              letterSpacing:
                                                                  1.2,
                                                            ),
                                                          ),
                                                          leading:
                                                              const CircleAvatar(
                                                            radius: 25,
                                                            backgroundColor:
                                                                Color(
                                                                    0xFFE1E2E2),
                                                            child: CircleAvatar(
                                                              radius: 23,
                                                              backgroundImage:
                                                                  AssetImage(
                                                                "assets/2m.jpg",
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        // loggedinuser!.userType == "admin"
                                                        //     ? Positioned(
                                                        //         top: 5,
                                                        //         right: 5,
                                                        //         child: IconButton(
                                                        //           onPressed: () {
                                                        //             //

                                                        //             //
                                                        //           },
                                                        //           icon: const ImageIcon(
                                                        //             AssetImage(
                                                        //               "assets/edit.png",
                                                        //             ),
                                                        //             color: Colors.black,
                                                        //             size: 25,
                                                        //           ),
                                                        //         ),
                                                        //       )
                                                        //     : const SizedBox(),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 12,
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    TextWidget(
                                                                      title:
                                                                          "Retail Value: £",
                                                                      txtSize:
                                                                          12,
                                                                      txtColor:
                                                                          txtColor,
                                                                    ),
                                                                    TextWidget(
                                                                      title: product
                                                                          .retailvalue
                                                                          .toString(),
                                                                      txtSize:
                                                                          12,
                                                                      txtColor:
                                                                          txtColor
                                                                              .withOpacity(.8),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    TextWidget(
                                                                      title:
                                                                          "Lot Number: ",
                                                                      txtSize:
                                                                          12,
                                                                      txtColor:
                                                                          txtColor,
                                                                    ),
                                                                    TextWidget(
                                                                      title: product
                                                                          .lotNo,
                                                                      txtSize:
                                                                          12,
                                                                      txtColor:
                                                                          txtColor
                                                                              .withOpacity(.8),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            product.productType ==
                                                                    "Sold"
                                                                ? const ImageIcon(
                                                                    AssetImage(
                                                                      "assets/sold.png",
                                                                    ),
                                                                    color: Colors
                                                                        .red,
                                                                    size: 40,
                                                                  )
                                                                : product.productType ==
                                                                        "UnSold"
                                                                    ? IconButton(
                                                                        onPressed:
                                                                            () async {
                                                                          await productprovider!.updateType(
                                                                              type: 'gen',
                                                                              pid: product.id);
                                                                          snackBar(
                                                                              context,
                                                                              "Item updated for reselling.");
                                                                        },
                                                                        icon:
                                                                            const ImageIcon(
                                                                          AssetImage(
                                                                            "assets/resell.png",
                                                                          ),
                                                                          color:
                                                                              Colors.greenAccent,
                                                                          size:
                                                                              40,
                                                                        ),
                                                                      )
                                                                    : const SizedBox(),
                                                          ],
                                                        ),
                                                        product.productType ==
                                                                "UnSold"
                                                            ? Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  vertical: 10,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      scfColor3,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                    horizontal:
                                                                        10.0,
                                                                    vertical: 5,
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      TextWidget(
                                                                        title:
                                                                            "Last Auctioned At: ",
                                                                        txtSize:
                                                                            12,
                                                                        txtColor:
                                                                            txtColor,
                                                                      ),
                                                                      TextWidget(
                                                                        title: product
                                                                            .auctioneddatetime!,
                                                                        txtSize:
                                                                            12,
                                                                        txtColor:
                                                                            txtColor.withOpacity(.8),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            : product.productType ==
                                                                    "Sold"
                                                                ? Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color:
                                                                          scfColor3,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                    ),
                                                                    margin: const EdgeInsets
                                                                        .symmetric(
                                                                      vertical:
                                                                          10,
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .symmetric(
                                                                        horizontal:
                                                                            10.0,
                                                                        vertical:
                                                                            5,
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          TextWidget(
                                                                            title:
                                                                                "Item Sold At: £",
                                                                            txtSize:
                                                                                12,
                                                                            txtColor:
                                                                                txtColor,
                                                                          ),
                                                                          TextWidget(
                                                                            title:
                                                                                "3458",
                                                                            txtSize:
                                                                                12,
                                                                            txtColor:
                                                                                txtColor.withOpacity(.8),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )
                                                                : const SizedBox(),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: product.image_urls
                                                            .isNotEmpty
                                                        ? 200
                                                        : 40,
                                                    margin:
                                                        const EdgeInsets.only(
                                                      top: 10,
                                                      left: 10,
                                                      right: 10,
                                                      bottom: 0,
                                                    ),
                                                    child: product.image_urls
                                                            .isNotEmpty
                                                        ? Image.network(
                                                            productImageIp +
                                                                product
                                                                    .image_urls
                                                                    .first,
                                                            fit: BoxFit.cover,
                                                            errorBuilder: (context,
                                                                    error,
                                                                    stackTrace) =>
                                                                const Icon(Icons
                                                                    .error),
                                                          )
                                                        : const Text(
                                                            'Image not available'),
                                                  ),
                                                  loggedinuser!.userType ==
                                                          "admin"
                                                      ? Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: product.productType ==
                                                                      "Sold" ||
                                                                  product.productType ==
                                                                      "UnSold"
                                                              ? const SizedBox()
                                                              : Row(
                                                                  children: [
                                                                    product.productType ==
                                                                            "Auction"
                                                                        ? IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              //

                                                                              //
                                                                            },
                                                                            icon:
                                                                                const ImageIcon(
                                                                              AssetImage(
                                                                                "assets/auction.png",
                                                                              ),
                                                                              color: Colors.red,
                                                                              size: 35,
                                                                            ),
                                                                          )
                                                                        : IconButton(
                                                                            onPressed:
                                                                                () async {
                                                                              await productprovider!.updateType(type: 'Auction', pid: product.id);
                                                                              // ignore: use_build_context_synchronously
                                                                              snackBar(
                                                                                context,
                                                                                "Item set to Auction",
                                                                              );
                                                                              //
                                                                            },
                                                                            icon:
                                                                                ImageIcon(
                                                                              const AssetImage(
                                                                                "assets/auction.png",
                                                                              ),
                                                                              color: product.productType == "Auction" ? Colors.redAccent : Colors.black,
                                                                              size: 35,
                                                                            ),
                                                                          ),
                                                                    const Spacer(),
                                                                    IconButton(
                                                                      onPressed:
                                                                          () async {
                                                                        await productprovider!.updateType(
                                                                            type:
                                                                                'Quick',
                                                                            pid:
                                                                                product.id);
                                                                        // ignore: use_build_context_synchronously
                                                                        snackBar(
                                                                          context,
                                                                          "Item set to Quick Sale",
                                                                        );
                                                                        //
                                                                      },
                                                                      icon:
                                                                          ImageIcon(
                                                                        const AssetImage(
                                                                          "assets/sale.png",
                                                                        ),
                                                                        color: product.productType ==
                                                                                "Quick"
                                                                            ? Colors.greenAccent
                                                                            : Colors.black,
                                                                        size:
                                                                            35,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                        )
                                                      : const SizedBox.shrink(),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 12,
                                                      vertical: 10,
                                                    ),
                                                    child: Text(
                                                      product.description,
                                                      maxLines: 4,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        // letterSpacing: 1.1,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink();
                          },
                        )
                      ],
                    ),
        )
      ],
    );
  }
}
