import 'package:acbaradise/Screens/MyCartScreen.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/DrawerWidget.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/GeneralProductsList.dart';
import 'package:acbaradise/Widgets/SingleWidgets/ExploreDivider.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/HomePageProductsList.dart';
import 'package:acbaradise/Widgets/SingleWidgets/MyCartBanner.dart';
import 'package:acbaradise/Widgets/SingleWidgets/ProductsForYouText.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/PurchaseBrands.dart';
import 'package:acbaradise/Widgets/SingleWidgets/ServiceAndAMCContainer.dart';
import 'package:flutter/material.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/HomePageProducts.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String uid;

  HomeScreen({Key? key,required this.uid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text(
          "AC Baradise",
          style: TextStyle(
            fontFamily: "Iceberg",
            fontSize: 25,
            color: blackColor,
          ),
        ),
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: Dark2ligthblueLRgradient,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => _scaffoldKey.currentState?.openEndDrawer(),
            child: Image.asset(
              'Assets/Icons/Profile_Icon.png', // Replace with the correct path to your image asset
              width: 50, // Adjust the width as needed
              height: 50, // Adjust the height as needed
              color: whiteColor, // Set the color of your icon
            ),
          ),
          const SizedBox(width: 10,),
        ],
      ),
      endDrawer: DrawerWidget(uid: uid,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ServiceAndAMCContainer(uid: uid,),
            ExploreDivider(),
            MyCartBanner(page: 'HomePage',),
            const SizedBox(
              height: 20,
            ),
            ProductsForYouText(),
            HomePageProducts(uid: uid,),
            const SizedBox(
              height: 20,
            ),
            PurchaseBrands(),
            GeneralProductsList(uid: uid),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
