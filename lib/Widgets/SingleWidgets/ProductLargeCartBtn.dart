import 'package:acbaradise/Models/DataBaseHelper.dart';
import 'package:acbaradise/Screens/MyCartScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:acbaradise/Theme/Colors.dart';

class ProductLargeCartBtn extends StatefulWidget {
  final String img;
  final String title;
  final String uid;
  final String productid;
  final int stock;

  ProductLargeCartBtn({
    super.key,
    required this.img,
    required this.title,
    required this.uid,
    required this.productid,
    required this.stock,
  });

  @override
  State<ProductLargeCartBtn> createState() => _ProductLargeCartBtnState();
}

class _ProductLargeCartBtnState extends State<ProductLargeCartBtn> {
  bool isProductInCart = false;

  @override
  void initState() {
    super.initState();
    checkProductInCart();
  }

  Future<void> checkProductInCart() async {
    try {
      QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.uid)
          .collection('ProductsCart')
          .get();

      setState(() {
        isProductInCart =
            cartSnapshot.docs.any((doc) => doc.id == widget.productid);
      });
    } catch (error) {
      print('Error checking product in cart: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isProductInCart
          ? () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyCartScreen(uid: widget.uid)));
            }
          : () async {
              if (widget.stock > 0) {
                String uid = widget.uid;
                Map<String, dynamic> productDetails = {
                  'count': 1,
                };
                try {
                  await DatabaseHelper.addToProductCart(
                    uid: uid,
                    productId: widget.productid,
                    productDetails: productDetails,
                  );

                  checkProductInCart();
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
              height: 60,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: isProductInCart
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: lightBlue50Color,
                    )
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: Light2darkblueLRgradient,
                    ),
              child: Center(
                child: Text(
                  isProductInCart ? "Go To Cart" : "Add To Cart",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "LexendMedium",
                    color: blackColor,
                  ),
                ),
              ),
            )
          : Container(
              height: 60,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: isProductInCart
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: darkGrey50Color,
                    )
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: darkGrey50Color,
                    ),
              child: Center(
                child: Text(
                  'Out of Stock',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "LexendMedium",
                    color: blackColor,
                  ),
                ),
              ),
            ),
    );
  }
}
