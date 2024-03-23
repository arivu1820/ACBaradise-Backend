import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/AMCInCart.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/GeneralProductsInCart.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/OrdersPhoneAdd.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/OrdersSummary.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/ProductsInCart.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/ServicesInCard.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/ServicesInOrder.dart';
import 'package:acbaradise/Widgets/SingleWidgets/AppbarWithCart.dart';
import 'package:flutter/material.dart';

class OrdersProductScreen extends StatelessWidget {
  final String uid;
  final String address;
  final String name;
  final String contact;
  final num totalamount;
  final List orderdetails;

  const OrdersProductScreen({
    super.key,
    required this.uid,
    required this.address,
    required this.contact,
    required this.name,
    required this.totalamount,
    required this.orderdetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: whiteColor,

      appBar: AppbarWithCart(
        PageName: "Orders",
        iscart: true,
        uid: uid,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                if (orderdetails[3]['GeneralProducts'].isNotEmpty)
                  GeneralProductsInCart(
                    isQtyReq: true,
                    uid: uid,
                    orderdetails: orderdetails[3],
                  ),
                if (orderdetails[2]['Products'].isNotEmpty)
                  ProductsInCart(
                    isQtyReq: true,
                    uid: uid,
                    orderdetails: orderdetails[2],
                  ),
                if (orderdetails[1]['Services'].isNotEmpty)
                  ServicesInOrder(
                    uid: uid,
                    orderdetails: orderdetails[1],
                  ),
                if (orderdetails[0]['AMC'].isNotEmpty)
                  AMCInCart(
                    isQtyReq: true,
                    uid: uid,
                    orderdetails: orderdetails[0],
                  ),
                OrdersSummary(
                  totalamount: totalamount,
                  orderdetails: orderdetails,
                ),
                OrdersPhoneAdd(
                  address: address,
                  contact: contact,
                  name: name,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
