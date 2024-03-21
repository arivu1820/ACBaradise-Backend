import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/OrdersCostContainer.dart';
import 'package:flutter/material.dart';

class OrdersSummary extends StatelessWidget {
  final num totalamount;
  final List orderdetails;

  OrdersSummary(
      {Key? key, required this.totalamount, required this.orderdetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Order Summary",
            style: const TextStyle(
              fontFamily: "LexendRegular",
              fontSize: 18,
              color: blackColor,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          OrdersCostContainer(
            totalamount: totalamount,
            getamount: getAmounts(),
          )
        ],
      ),
    );
  }

Map<String, num> getAmounts() {
  Map<String, num> amounts = {};

  // Handle Services
  if (orderdetails != null && orderdetails.isNotEmpty) {
    Map<String, dynamic> services = orderdetails[1]['Services'] ?? {};

    var serviceIds = services.keys.toList();
    num totalServicesOrderAmount = 0;

    for (var serviceId in serviceIds) {
      var serviceData = services[serviceId] as Map<String, dynamic>?;
      if (serviceData != null) {
        totalServicesOrderAmount += serviceData['totalPrice'] ?? 0;
      }
    }

    amounts['Services'] = totalServicesOrderAmount;
  }

  // Handle Products
  if (orderdetails != null && orderdetails!.isNotEmpty) {
    Map<String, dynamic> products = orderdetails![2]['Products'] ?? {};

    var productIds = products.keys.toList();
    num totalProductsOrderAmount = 0;

    for (var productId in productIds) {
      var productData = products[productId] as Map<String, dynamic>?;
      if (productData != null) {
        totalProductsOrderAmount += productData['totalPrice'] ?? 0;
      }
    }

    amounts['Products'] = totalProductsOrderAmount;
  }

    if (orderdetails != null && orderdetails!.isNotEmpty) {
    Map<String, dynamic> products = orderdetails![3]['GeneralProducts'] ?? {};

    var productIds = products.keys.toList();
    num totalProductsOrderAmount = 0;

    for (var productId in productIds) {
      var productData = products[productId] as Map<String, dynamic>?;
      if (productData != null) {
        totalProductsOrderAmount += productData['totalPrice'] ?? 0;
      }
    }

    amounts['GeneralProducts'] = totalProductsOrderAmount;
  }

  if (orderdetails != null && orderdetails!.isNotEmpty) {
    Map<String, dynamic> products = orderdetails![0]['AMC'] ?? {};

    var productIds = products.keys.toList();
    num totalProductsOrderAmount = 0;

    for (var productId in productIds) {
      var productData = products[productId] as Map<String, dynamic>?;
      if (productData != null) {
        totalProductsOrderAmount += productData['totalPrice'] ?? 0;
      }
    }

    amounts['AMC'] = totalProductsOrderAmount;
  }
  return amounts;
}

}
