import 'package:acbaradise/Theme/Colors.dart';
import 'package:flutter/material.dart';

class OrdersPhoneAdd extends StatelessWidget {
  final String address;
  final String name ;
  final String contact;

  const OrdersPhoneAdd({Key? key, required this.address, required this.contact, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Placed Address",
            style: const TextStyle(
              fontFamily: "LexendRegular",
              fontSize: 18,
              color: blackColor,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            address,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: "LexendLight",
              color: blackColor,
            ),
          ),
          SizedBox(height: 20,),
          Text(
            name+" - +91 "+contact,
            
            style: const TextStyle(
              fontSize: 14,
              fontFamily: "LexendRegular",
              color: blackColor,
            ),
          ),
          SizedBox(height: 30,)
        ],
      ),
    );
  }
}
