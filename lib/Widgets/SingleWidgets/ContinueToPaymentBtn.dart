import 'package:acbaradise/Screens/PaymentScreen.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ContinueToPayment extends StatelessWidget {
  final String uid;
  final num totalprice;
  final Map<String,dynamic> allserviceproductdetails;
  const ContinueToPayment({super.key,required this.uid,required this.totalprice,required this.allserviceproductdetails});

  @override
  Widget build(BuildContext context) {
    var uuid = Uuid();
    String uniqueid = uuid.v4();
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.5, color: lightBlueColor),
        ),
        color: whiteColor,
      ),
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Pay",
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: "LexendLight",
                  color: blackColor,
                ),
              ),
              Text(
                '₹ ${NumberFormat('#,##,##0.00').format(totalprice
                                    )}  ',
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: "LexendMedium",
                  color: blackColor,
                ),
              )
            ],
          ),
          Expanded(
            child: GestureDetector(
              onTap:totalprice<=0.00?(){}: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(uid: uid,amount: totalprice,allincart: allserviceproductdetails,uniqueid: uniqueid,),
                    ));
              },
              child: Container(
                height: 60,
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color:totalprice<=0.00? lightBlue50Color:lightBlueColor,
                ),
                child: Center(
                  child: Text(
                    "Continue To Payment",
                    textAlign: TextAlign.center,
                    style:  TextStyle(
                      fontSize: 18,
                      fontFamily: "LexendLight",
                      color:totalprice<=0.00? black50Color : blackColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
