import 'package:acbaradise/Models/DataBaseHelper.dart';
import 'package:acbaradise/Screens/MyCartScreen.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductCartBtn extends StatefulWidget {
  final String img;
  final String title;
  final String uid;
  final String productid;
  final int stock;
  ProductCartBtn({
    super.key,
    required this.img,
    required this.title,
    required this.uid,
    required this.productid,
    required this.stock,
    
  });

  @override
  State<ProductCartBtn> createState() => _ProductCartBtnState();
}

class _ProductCartBtnState extends State<ProductCartBtn> {
  bool iscarted = false;

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
          ? () {}
          : () async {
              String uid = widget.uid;
              Map<String, dynamic> productDetails = {
                'count': 1,
              };
              if (widget.stock > 0) {
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
      child:widget.stock > 0? GestureDetector(
         onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyCartScreen(uid: widget.uid),
                ),
              ),
        child: Container(
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
        ),
      ): Container(
        height: 40,
        width: 200,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: darkGrey50Color,
        ),
        child: Center(
          child: Text('Out of Stock',
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
