import 'package:acbaradise/Theme/Colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ACPContainer extends StatelessWidget {
  final bool ifTrue;
  final DateTime CreatedAt;
  final String OrderId;
  final num TotalPrice;
  final String OrderTitle;

  const ACPContainer({Key? key, required this.ifTrue,this.OrderTitle='', required this.CreatedAt, required this.OrderId, required this.TotalPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.fromLTRB(20,10,20,0),
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
            color: whiteColor,
            border: Border.all(color: lightBlue75Color, width: 1),
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(OrderTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: "LexendRegular",
                      color: black90Color,
                    ),
                  ),
                ),
                SizedBox(
                  height: 0,
                  width: 60,
                  child: Container(
                    color: darkBlueColor,
                  ),
                ),
                Text(
                                  '₹ ${NumberFormat('#,##,##0.00').format(TotalPrice)}  ',
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: "LexendRegular",
                    color: black90Color,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 9,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order #"+OrderId,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10,
                          fontFamily: "LexendLight",
                          color: black90Color,
                        ),
                      ),
                      Text(
                        DateFormat('dd MMM yyyy').format(CreatedAt),
                        style: const TextStyle(
                          fontSize: 10,
                          fontFamily: "LexendLight",
                          color: black90Color,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20,),
                Image.asset(
                  ifTrue
                      ? "Assets/Icons/Fulfilled.png"
                      : "Assets/Icons/Group_82.png",
                  height: ifTrue ? 15 : 20,
                  width: ifTrue ? 55 : 55,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
