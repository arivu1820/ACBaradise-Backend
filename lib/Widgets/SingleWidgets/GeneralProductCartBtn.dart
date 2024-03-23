import 'package:acbaradise/Models/DataBaseHelper.dart';
import 'package:acbaradise/Screens/MyCartScreen.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GeneralProductCartBtn extends StatefulWidget {
  final String img;
  final String title;
  final String uid;
  final String productid;
  final int stock;
  GeneralProductCartBtn({
    super.key,
    required this.img,
    required this.title,
    required this.uid,
    required this.productid,
    required this.stock,
  });

  @override
  State<GeneralProductCartBtn> createState() => _ProductCartBtnState();
}

class _ProductCartBtnState extends State<GeneralProductCartBtn> {
  bool iscarted = false;

  @override
  void initState() {
    super.initState();
    checkGeneralProductInCart();
  }

  Future<void> checkGeneralProductInCart() async {
    try {
      QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.uid)
          .collection('GeneralProductsCart')
          .get();

      setState(() {
        iscarted = cartSnapshot.docs.any((doc) => doc.id == widget.productid);
      });
    } catch (error) {
      print('Error checking product in cart: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: iscarted
          ? () { 
             Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyCartScreen(uid: widget.uid),
                ),
              );
          }
          : () async {
              String uid = widget.uid;
              Map<String, dynamic> productDetails = {
                'count': 1,
              };
              if (widget.stock > 0) {
                try {
                  await DatabaseHelper.addToGeneralProductCart(
                    uid: uid,
                    productId: widget.productid,
                    productDetails: productDetails,
                  );

                  checkGeneralProductInCart();
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error adding to cart: $error'),
                    ),
                  );
                }
              }
            },
      child: widget.stock > 0
          ? Container(
            height: 40,
            width: 200,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: iscarted ? lightBlue50Color : null,
              gradient: iscarted ? null : Light2darkblueLRgradient,
            ),
            child: Center(
              child: Text(
                iscarted ? "Go To Cart" : "Add To Cart",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: "LexendMedium",
                  color: blackColor,
                ),
              ),
            ),
          )
          : Container(
              height: 40,
              width: 200,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: darkGrey50Color,
              ),
              child: Center(
                child: Text(
                  'Out of Stock',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: "LexendMedium",
                    color: blackColor,
                  ),
                ),
              ),
            ),
    );
  }
}
