import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/SingleWidgets/CardAddBtn.dart';
import 'package:acbaradise/Widgets/SingleWidgets/OrderPriceWithout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CartAMCContainer extends StatelessWidget {
  final bool isQtyReq;
  final String productid;
  final String uid;
  final num orderamount;
  final int count;

  final String title;
  CartAMCContainer({super.key, required this.isQtyReq,this.productid='',required this.title,required this.uid,this.orderamount=0, this.count=0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(color: Colors.transparent),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: "LexendLight",
                fontSize: 15,
                color: blackColor,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          isQtyReq ?   OrderPriceWithout(orderamount: orderamount,count: count,):CartAddBtn(productid: productid,uid: uid,collectionid: "AMCCart",servicedoc: '5AMC',servicecoll: 'AMC',)
        ],
      ),
    );
  }
}
