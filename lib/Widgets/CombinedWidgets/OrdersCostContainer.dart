import 'package:acbaradise/Theme/Colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrdersCostContainer extends StatelessWidget {
  final num totalamount;
  final Map<String, dynamic> getamount;

  const OrdersCostContainer({super.key, required this.totalamount, required this.getamount});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      // padding: const EdgeInsets.all(20),
      // margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
      width: double.infinity,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                              "Products",
                              style: TextStyle(
                                fontFamily: "LexendLight",
                                fontSize: 14,
                                color: blackColor,
                              ),
                            ),
                  ),
                  Text(
                                  '₹ ${NumberFormat('#,##,##0.00').format(getamount['Products'])}  ',
                              style: TextStyle(
                                fontFamily: "LexendLight",
                                fontSize: 14,
                                color: blackColor,
                              ),
                            ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: Text(
                              "General",
                              style: TextStyle(
                                fontFamily: "LexendLight",
                                fontSize: 14,
                                color: blackColor,
                              ),
                            ),
                  ),
                  Text(
                                  '₹ ${NumberFormat('#,##,##0.00').format(getamount['GeneralProducts'])}  ',
                              style: TextStyle(
                                fontFamily: "LexendLight",
                                fontSize: 14,
                                color: blackColor,
                              ),
                            ),
                ],
              ),
                            const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: Text(
                              "Services",
                              style: TextStyle(
                                fontFamily: "LexendLight",
                                fontSize: 14,
                                color: blackColor,
                              ),
                            ),
                  ),
                  Text(
                                  '₹ ${NumberFormat('#,##,##0.00').format(getamount['Services'])}  ',
                              style: TextStyle(
                                fontFamily: "LexendLight",
                                fontSize: 14,
                                color: blackColor,
                              ),
                            ),
                ],
              ),
                            const SizedBox(height: 10,),

              Row(
                children: [
                  Expanded(
                    child: Text(
                              "AMC",
                              style: TextStyle(
                                fontFamily: "LexendLight",
                                fontSize: 14,
                                color: blackColor,
                              ),
                            ),
                  ),
                  Text(
                                  '₹ ${NumberFormat('#,##,##0.00').format(getamount['AMC'])}  ',
                              style: TextStyle(
                                fontFamily: "LexendLight",
                                fontSize: 14,
                                color: blackColor,
                              ),
                            ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
              child: Container(
            height: 1,
            width: screenWidth - 60,
            color: lightGrayColor,
          )),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Total",
                  style: TextStyle(
                    fontFamily: "LexendRegular",
                    fontSize: 16,
                    color: blackColor,
                  ),
                ),
              ),
              Text(
                                  '₹ ${NumberFormat('#,##,##0.00').format(totalamount)}  ',
                style: TextStyle(
                  fontFamily: "LexendRegular",
                  fontSize: 16,
                  color: blackColor,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
