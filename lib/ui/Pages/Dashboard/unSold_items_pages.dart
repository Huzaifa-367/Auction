import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/Global/Global.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/SnackBar/SnackBar.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/cards/white_card.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/labels/TextWidget.dart';
import 'package:flutter_admin_dashboard/api/ApiHandler.dart';
import 'package:flutter_admin_dashboard/models/Bidder_Model.dart';
import 'package:flutter_admin_dashboard/models/Product_Model.dart';
import 'package:flutter_admin_dashboard/providers/BiddersProvider.dart';
import 'package:flutter_admin_dashboard/providers/Controllers.dart';
import 'package:flutter_admin_dashboard/providers/productsProvider.dart';
import 'package:flutter_admin_dashboard/providers/side_menu_provider.dart';
import 'package:flutter_admin_dashboard/services/navigation_service.dart';
import 'package:flutter_admin_dashboard/ui/Pages/Dashboard/AddProduct_POP.dart';
import 'package:flutter_admin_dashboard/ui/Pages/Dashboard/AllProductsView.dart';
import 'package:flutter_admin_dashboard/ui/Pages/Dashboard/Presenter_Screen.dart';
import 'package:flutter_admin_dashboard/ui/Pages/Dashboard/Telephonist_NewBid.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class unSoldItemsPage extends StatefulWidget {
  const unSoldItemsPage({super.key});

  @override
  State<unSoldItemsPage> createState() => _unSoldItemsPageState();
}

class _unSoldItemsPageState extends State<unSoldItemsPage> {
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
  }

  @override
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
            title: "Unsold Products",
            width: MediaQuery.of(context).size.width,
            child: productstype(
                context, productprovider, bidderProvider, "UnSold"),
          ),
        ],
      ),
    );
  }
}

Widget productstype(context, productprovider, bidderProvider, type) {
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
                            return product.productType == type
                                ? GestureDetector(
                                    onTap: () {
                                      if (product.productType == 'Auction') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PresenterView(
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
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
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
                                                        type == "Sold"
                                                            ? Column(
                                                                children: [
                                                                  const ImageIcon(
                                                                    AssetImage(
                                                                      "assets/sold.png",
                                                                    ),
                                                                    color: Colors
                                                                        .red,
                                                                    size: 40,
                                                                  ),
                                                                  IconButton(
                                                                    onPressed:
                                                                        () async {
                                                                      await productprovider!.updateVisibility(
                                                                          isVisible: !product
                                                                              .isVisible,
                                                                          pid: product
                                                                              .id);
                                                                      snackBar(
                                                                          context,
                                                                          "Item visibility updated.",
                                                                          null);
                                                                    },
                                                                    icon: product
                                                                            .isVisible
                                                                        ? const ImageIcon(
                                                                            AssetImage(
                                                                              "assets/visible.png",
                                                                            ),
                                                                            color:
                                                                                Colors.red,
                                                                            size:
                                                                                40,
                                                                          )
                                                                        : const ImageIcon(
                                                                            AssetImage(
                                                                              "assets/invisible.png",
                                                                            ),
                                                                            color:
                                                                                Colors.green,
                                                                            size:
                                                                                40,
                                                                          ),
                                                                  )
                                                                ],
                                                              )
                                                            : const SizedBox(),
                                                      ],
                                                    ),
                                                    type == "UnSold"
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
                                                        : const SizedBox(),
                                                    type == "UnSold"
                                                        ? IconButton(
                                                            onPressed:
                                                                () async {
                                                              await productprovider!
                                                                  .updateType(
                                                                      type:
                                                                          'gen',
                                                                      pid: product
                                                                          .id);
                                                              snackBar(
                                                                  context,
                                                                  "Item updated for reselling.",
                                                                  null);
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
                                                        : const SizedBox
                                                            .shrink(),
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
                                                                              null);
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
                                                                        null);
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
                                                  maxLines: 5,
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
