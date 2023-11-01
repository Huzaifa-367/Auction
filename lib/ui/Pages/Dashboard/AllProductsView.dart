import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/Global/Global.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/SnackBar/SnackBar.dart';
import 'package:flutter_admin_dashboard/models/Bidder_Model.dart';
import 'package:flutter_admin_dashboard/providers/BiddersProvider.dart';
import 'package:flutter_admin_dashboard/ui/Pages/Dashboard/AddProduct_POP.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/cards/white_card.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/labels/TextWidget.dart';
import 'package:flutter_admin_dashboard/providers/side_menu_provider.dart';
import 'package:flutter_admin_dashboard/services/navigation_service.dart';
import 'package:flutter_admin_dashboard/ui/Pages/Dashboard/Telephonist_NewBid.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_admin_dashboard/models/Product_Model.dart';
import '../../../api/ApiHandler.dart';
import '../../../providers/productsProvider.dart';
import 'package:flutter_admin_dashboard/providers/Controllers.dart';

import 'Presenter_Screen.dart';
//

class AllProductsView extends StatefulWidget {
  const AllProductsView({super.key});

  @override
  State<AllProductsView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<AllProductsView> {
  void navigateTo(String routeName) {
    NavigationService.navigateTo(routeName);
    SideMenuProvider.closeMenu();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productprovider ??= context.read<Productprovider>();

    bidderProvider ??= context.read<BidderProvider>();
    doThis();
  }

  doThis() async {
    try {
      await productprovider!.getProducts();

      //  Yahan pr logic lgao jis ko srf product screen show hogi dashboard nhi hogi true ki jgh

      if(true){
      if (bidderProvider!.auctionTimer != null) {
        bidderProvider!.auctionTimer!.cancel();
      }
      bidderProvider!.getAuction();
      }
    } catch (e) {}
  }

  final jobRoleCtrl = TextEditingController();
  final List<String> _items = [
    if (loggedinuser!.userType != "tele") ...{
      'All Items',
    },
    'Auction Items',
    'Quick Sale Items',
    if (loggedinuser!.userType != "tele") ...{
      'Sold Items',
      'UnSold Items',
    }
  ];

  Productprovider? productprovider;
  BidderProvider? bidderProvider;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sideMenuProvider = context.read<SideMenuProvider>();
    productprovider ??= context.read<Productprovider>();
    bidderProvider ??= context.read<BidderProvider>();
    return SingleChildScrollView(
      child: Column(
        children: [
          WhiteCard(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                  child: SizedBox(
                    width: 200,
                    child: CustomDropdown.search(
                      hintText: 'Apply Filter',
                      items: _items,
                      onChanged: (p0) {
                        productprovider!.applyFilter(toFilter: p0);
                      },
                      controller: jobRoleCtrl,
                    ),
                  ),
                ),
                loggedinuser!.userType == "admin"
                    ? Row(
                        children: [
                          TextWidget(
                            title: "Add Items",
                            txtSize: 15,
                            txtColor: txtColor,
                          ),
                          IconButton(
                            onPressed: () {
                              //Dialog
                              showDialog(
                                //useSafeArea: true,
                                //To disable alert background
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => AlertDialog(
                                  icon: Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      onPressed: (() {
                                        Navigator.of(context).pop();
                                      }),
                                      icon: const Icon(Icons.cancel_outlined),
                                    ),
                                  ),
                                  content: const AddProduct_POP(),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: btnColor,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 25,
                                          vertical: 10,
                                        ),
                                        child: const TextWidget(
                                            title: "Cancel",
                                            txtSize: 15,
                                            txtColor: Colors.white),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Product p = Product(
                                            auctionTime: int.parse(
                                                Controllers.timmer.text),
                                            qty: Controllers.qty.text,
                                            type: "gen",
                                            productType: 'gen',
                                            description: Controllers
                                                .descriptionController.text,
                                            donorName: Controllers
                                                .donor_name_controller.text,
                                            id: 0,
                                            lotNo: Controllers.lotnumber.text,
                                            name: Controllers.p_name.text,
                                            isLive: false,
                                            image_urls: [],
                                            isQuickSale: false,
                                            logo: '',
                                            retailvalue:
                                                Controllers.retailPrice.text);
                                        await productprovider!.addProduct(
                                            p, productprovider!.pickedFiles);
                                        //snackBar(context, "Saved Successfully");
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: btnColor,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 25,
                                          vertical: 10,
                                        ),
                                        child: const TextWidget(
                                            title: "Save",
                                            txtSize: 15,
                                            txtColor: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.add,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          WhiteCard(
            title: "Products",
            width: MediaQuery.of(context).size.width,
            child: products(),
          ),
        ],
      ),
    );
  }

  Widget products() {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(height: 15),
        Consumer<Productprovider>(
          builder: (context, value, child) {
            return value.isGettingProducts
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
                                      loggedinuser!.userType == "tele"
                                  ? (loggedinuser!.userType != "tele" &&
                                          context
                                                  .watch<BidderProvider>()
                                                  .productId ==
                                              product.id &&
                                          (bidderProvider!.startedTime ?? 0) <
                                              product.auctionTime)
                                      ? const SizedBox.shrink()
                                      : GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PresenterView(
                                                  product: product,
                                                ),
                                              ),
                                            );
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
                                                      Radius.circular(20)),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: product.productType ==
                                                          "Auction"
                                                      ? const Color.fromARGB(
                                                          255, 252, 233, 220)
                                                      : product.productType ==
                                                              "Quick"
                                                          ? const Color.fromARGB(
                                                              255,
                                                              184,
                                                              254,
                                                              227)
                                                          : product.productType ==
                                                                      "Sold" &&
                                                                  loggedinuser!
                                                                          .userType !=
                                                                      "tele"
                                                              ? const Color
                                                                  .fromARGB(146,
                                                                  187, 250, 246)
                                                              : Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(20)),
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
                                                              width: double
                                                                  .infinity,
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
                                                                    fontSize:
                                                                        15,
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
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 23,
                                                                backgroundImage:
                                                                    AssetImage(
                                                                  "assets/2m.jpg",
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: 5,
                                                            right: 5,
                                                            child: IconButton(
                                                              onPressed: () {
                                                                //
                                                                showDialog(
                                                                  barrierDismissible:
                                                                      false,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          AlertDialog(
                                                                    icon: Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topRight,
                                                                      child:
                                                                          IconButton(
                                                                        onPressed:
                                                                            (() {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        }),
                                                                        icon: const Icon(
                                                                            Icons.cancel_outlined),
                                                                      ),
                                                                    ),
                                                                    content:
                                                                        NewBidding_PopUp(
                                                                      productName:
                                                                          product
                                                                              .name,
                                                                    ),
                                                                    //title: const Text("Alert Dialog Box"),
                                                                    //content: const Text("Do you want to login?"),
                                                                    actions: <Widget>[
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                btnColor,
                                                                            borderRadius:
                                                                                BorderRadius.circular(25),
                                                                          ),
                                                                          padding:
                                                                              const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                25,
                                                                            vertical:
                                                                                10,
                                                                          ),
                                                                          child: const TextWidget(
                                                                              title: "Cancel",
                                                                              txtSize: 15,
                                                                              txtColor: Colors.white),
                                                                        ),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed:
                                                                            () async {
                                                                          await bidderProvider!
                                                                              .addBidder(
                                                                            bidder:
                                                                                Bidder(
                                                                              id: 0,
                                                                              product_id: product.id,
                                                                              user_Name: Controllers.biddername.text,
                                                                              phoneNo: Controllers.telephone.text,
                                                                              amount: int.parse(Controllers.amount.text),
                                                                            ),
                                                                          );
                                                                          // ignore: use_build_context_synchronously
                                                                          snackBar(
                                                                              context,
                                                                              "Saved Successfully",
                                                                              null);
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                btnColor,
                                                                            borderRadius:
                                                                                BorderRadius.circular(25),
                                                                          ),
                                                                          padding:
                                                                              const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                25,
                                                                            vertical:
                                                                                10,
                                                                          ),
                                                                          child: const TextWidget(
                                                                              title: "Save",
                                                                              txtSize: 15,
                                                                              txtColor: Colors.white),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );

                                                                //
                                                              },
                                                              icon:
                                                                  const ImageIcon(
                                                                AssetImage(
                                                                  "assets/auction.png",
                                                                ),
                                                                color: Colors
                                                                    .black,
                                                                size: 35,
                                                              ),
                                                            ),
                                                          ),
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
                                                                            txtColor.withOpacity(.8),
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
                                                                            txtColor.withOpacity(.8),
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
                                                                  : const SizedBox(),
                                                            ],
                                                          ),
                                                          // product.productType ==
                                                          //         "UnSold"
                                                          //     ? Container(
                                                          //         margin: const EdgeInsets
                                                          //             .symmetric(
                                                          //           vertical:
                                                          //               10,
                                                          //         ),
                                                          //         decoration:
                                                          //             BoxDecoration(
                                                          //           color:
                                                          //               scfColor3,
                                                          //           borderRadius:
                                                          //               BorderRadius.circular(
                                                          //                   15),
                                                          //         ),
                                                          //         child:
                                                          //             Padding(
                                                          //           padding:
                                                          //               const EdgeInsets
                                                          //                   .symmetric(
                                                          //             horizontal:
                                                          //                 10.0,
                                                          //             vertical:
                                                          //                 5,
                                                          //           ),
                                                          //           child: Row(
                                                          //             children: [
                                                          //               TextWidget(
                                                          //                 title:
                                                          //                     "Last Auctioned At: ",
                                                          //                 txtSize:
                                                          //                     12,
                                                          //                 txtColor:
                                                          //                     txtColor,
                                                          //               ),
                                                          //               TextWidget(
                                                          //                 title:
                                                          //                     "11:15 on 02/12/2023",
                                                          //                 txtSize:
                                                          //                     12,
                                                          //                 txtColor:
                                                          //                     txtColor.withOpacity(.8),
                                                          //               ),
                                                          //             ],
                                                          //           ),
                                                          //         ),
                                                          //       )
                                                          //     : product.productType ==
                                                          //             "Sold"
                                                          //         ? Container(
                                                          //             decoration:
                                                          //                 BoxDecoration(
                                                          //               color:
                                                          //                   scfColor3,
                                                          //               borderRadius:
                                                          //                   BorderRadius.circular(15),
                                                          //             ),
                                                          //             margin: const EdgeInsets
                                                          //                 .symmetric(
                                                          //               vertical:
                                                          //                   10,
                                                          //             ),
                                                          //             child:
                                                          //                 Padding(
                                                          //               padding:
                                                          //                   const EdgeInsets.symmetric(
                                                          //                 horizontal:
                                                          //                     10.0,
                                                          //                 vertical:
                                                          //                     5,
                                                          //               ),
                                                          //               child:
                                                          //                   Row(
                                                          //                 children: [
                                                          //                   TextWidget(
                                                          //                     title: "Iten Sold At: £",
                                                          //                     txtSize: 12,
                                                          //                     txtColor: txtColor,
                                                          //                   ),
                                                          //                   TextWidget(
                                                          //                     title: "3458",
                                                          //                     txtSize: 12,
                                                          //                     txtColor: txtColor.withOpacity(.8),
                                                          //                   ),
                                                          //                 ],
                                                          //               ),
                                                          //             ),
                                                          //           )
                                                          //         : const SizedBox(),
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
                                                        maxLines: 5,
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
                                  : loggedinuser!.userType == "admin"
                                      ? GestureDetector(
                                          onTap: () {
                                            if (product.productType ==
                                                'Auction') {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PresenterView(
                                                    product: product,
                                                  ),
                                                ),
                                              );
                                            }
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
                                                      Radius.circular(20)),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: product.productType ==
                                                          "Auction"
                                                      ? const Color.fromARGB(
                                                          255, 252, 233, 220)
                                                      : product.productType ==
                                                              "Quick"
                                                          ? const Color.fromARGB(
                                                              255,
                                                              184,
                                                              254,
                                                              227)
                                                          : product.productType ==
                                                                      "Sold" &&
                                                                  loggedinuser!
                                                                          .userType !=
                                                                      "tele"
                                                              ? const Color
                                                                  .fromARGB(146,
                                                                  187, 250, 246)
                                                              : Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(20)),
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
                                                              width: double
                                                                  .infinity,
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
                                                                    fontSize:
                                                                        15,
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
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 23,
                                                                backgroundImage:
                                                                    AssetImage(
                                                                  "assets/2m.jpg",
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: 5,
                                                            right: 5,
                                                            child: loggedinuser!
                                                                        .userType ==
                                                                    "admin"
                                                                ? IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      //
                                                                      showDialog(
                                                                        //useSafeArea: true,
                                                                        //To disable alert background
                                                                        barrierDismissible:
                                                                            false,
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) =>
                                                                                AlertDialog(
                                                                          icon:
                                                                              Align(
                                                                            alignment:
                                                                                Alignment.topRight,
                                                                            child:
                                                                                IconButton(
                                                                              onPressed: (() {
                                                                                Navigator.of(context).pop();
                                                                              }),
                                                                              icon: const Icon(Icons.cancel_outlined),
                                                                            ),
                                                                          ),
                                                                          content:
                                                                              const AddProduct_POP(),
                                                                          //title: const Text("Alert Dialog Box"),
                                                                          //content: const Text("Do you want to login?"),
                                                                          actions: <Widget>[
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
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
                                                                                child: const TextWidget(title: "Cancel", txtSize: 15, txtColor: Colors.white),
                                                                              ),
                                                                            ),
                                                                            TextButton(
                                                                              onPressed: () async {
                                                                                Product p = Product(qty: Controllers.qty.text, auctionTime: int.parse(Controllers.timmer.text), type: "gen", productType: 'gen', description: Controllers.descriptionController.text, donorName: Controllers.donor_name_controller.text, id: 0, lotNo: Controllers.lotnumber.text, name: Controllers.p_name.text, isLive: false, image_urls: [], isQuickSale: false, logo: '', retailvalue: Controllers.retailPrice.text);
                                                                                await productprovider!.addProduct(p, productprovider!.pickedFiles);
                                                                                //snackBar(context, "Saved Successfully");
                                                                                Navigator.of(context).pop();
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
                                                                                child: const TextWidget(title: "Save", txtSize: 15, txtColor: Colors.white),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      );

                                                                      //
                                                                    },
                                                                    icon:
                                                                        const ImageIcon(
                                                                      AssetImage(
                                                                        "assets/edit.png",
                                                                      ),
                                                                      color: Colors
                                                                          .black,
                                                                      size: 25,
                                                                    ),
                                                                  )
                                                                : loggedinuser!.userType ==
                                                                            "tele" &&
                                                                        (product.productType ==
                                                                                "Auction" ||
                                                                            product.productType ==
                                                                                "Quick")
                                                                    ? IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          //
                                                                          showDialog(
                                                                            barrierDismissible:
                                                                                false,
                                                                            context:
                                                                                context,
                                                                            builder: (context) =>
                                                                                AlertDialog(
                                                                              icon: Align(
                                                                                alignment: Alignment.topRight,
                                                                                child: IconButton(
                                                                                  onPressed: (() {
                                                                                    Navigator.of(context).pop();
                                                                                  }),
                                                                                  icon: const Icon(Icons.cancel_outlined),
                                                                                ),
                                                                              ),
                                                                              content: NewBidding_PopUp(
                                                                                productName: product.name,
                                                                              ),
                                                                              //title: const Text("Alert Dialog Box"),
                                                                              //content: const Text("Do you want to login?"),
                                                                              actions: <Widget>[
                                                                                TextButton(
                                                                                  onPressed: () {
                                                                                    Navigator.of(context).pop();
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
                                                                                    child: const TextWidget(title: "Cancel", txtSize: 15, txtColor: Colors.white),
                                                                                  ),
                                                                                ),
                                                                                TextButton(
                                                                                  onPressed: () async {
                                                                                    await bidderProvider!.addBidder(
                                                                                      bidder: Bidder(
                                                                                        id: 0,
                                                                                        product_id: 1,
                                                                                        user_Name: Controllers.biddername.text,
                                                                                        phoneNo: Controllers.telephone.text,
                                                                                        amount: int.parse(Controllers.amount.text),
                                                                                      ),
                                                                                    );

                                                                                    // ignore: use_build_context_synchronously
                                                                                    snackBar(
                                                                                      context,
                                                                                      "Saved Successfully",
                                                                                      null,
                                                                                    );
                                                                                    Navigator.of(context).pop();
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
                                                                                    child: const TextWidget(title: "Save", txtSize: 15, txtColor: Colors.white),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );

                                                                          //
                                                                        },
                                                                        icon:
                                                                            const ImageIcon(
                                                                          AssetImage(
                                                                            "assets/auction.png",
                                                                          ),
                                                                          color:
                                                                              Colors.black,
                                                                          size:
                                                                              35,
                                                                        ),
                                                                      )
                                                                    : const SizedBox(),
                                                          ),
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
                                                                            txtColor.withOpacity(.8),
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
                                                                            txtColor.withOpacity(.8),
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
                                                                  : const SizedBox(),
                                                            ],
                                                          ),
                                                          product.productType ==
                                                                  "UnSold"
                                                              ? Container(
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                    vertical:
                                                                        10,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color:
                                                                        scfColor3,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
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
                                                                          title:
                                                                              "11:15 on 02/12/2023",
                                                                          txtSize:
                                                                              12,
                                                                          txtColor:
                                                                              txtColor.withOpacity(.8),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                              // : product.productType ==
                                                              //         "Sold"
                                                              //     ? Container(
                                                              //         decoration:
                                                              //             BoxDecoration(
                                                              //           color:
                                                              //               scfColor3,
                                                              //           borderRadius:
                                                              //               BorderRadius.circular(15),
                                                              //         ),
                                                              //         margin: const EdgeInsets
                                                              //             .symmetric(
                                                              //           vertical:
                                                              //               10,
                                                              //         ),
                                                              //         child:
                                                              //             Padding(
                                                              //           padding:
                                                              //               const EdgeInsets.symmetric(
                                                              //             horizontal:
                                                              //                 10.0,
                                                              //             vertical:
                                                              //                 5,
                                                              //           ),
                                                              //           child:
                                                              //               Row(
                                                              //             children: [
                                                              //               TextWidget(
                                                              //                 title: "Iten Sold At: £",
                                                              //                 txtSize: 12,
                                                              //                 txtColor: txtColor,
                                                              //               ),
                                                              //               TextWidget(
                                                              //                 title: "3458",
                                                              //                 txtSize: 12,
                                                              //                 txtColor: txtColor.withOpacity(.8),
                                                              //               ),
                                                              //             ],
                                                              //           ),
                                                              //         ),
                                                              //       )

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
                                                        maxLines: 5,
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
                      );
          },
        )
      ],
    );
  }
}
