import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/Global/Widgets/cards/white_card.dart';
import 'package:flutter_admin_dashboard/providers/BiddersProvider.dart';
import 'package:flutter_admin_dashboard/providers/productsProvider.dart';
import 'package:flutter_admin_dashboard/providers/side_menu_provider.dart';
import 'package:flutter_admin_dashboard/services/navigation_service.dart';
import 'package:flutter_admin_dashboard/ui/Pages/Dashboard/AllProductsView.dart';
import 'package:provider/provider.dart';

class SoldItemsPage extends StatefulWidget {
  const SoldItemsPage({super.key});

  @override
  State<SoldItemsPage> createState() => _SoldItemsPageState();
}

class _SoldItemsPageState extends State<SoldItemsPage> {
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
            title: "Sold Products",
            width: MediaQuery.of(context).size.width,
            child: products(context, productprovider, bidderProvider),
          ),
        ],
      ),
    );
  }
}
