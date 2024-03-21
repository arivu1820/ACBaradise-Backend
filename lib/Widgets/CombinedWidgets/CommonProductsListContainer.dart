import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/SingleWidgets/GeneralProductCartBtn.dart';
import 'package:acbaradise/Widgets/SingleWidgets/ProductCartBtn.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommonProductsListContainer extends StatelessWidget {
  final String productName;
  final String imageUrl;
  final int mrp;
  final String uid;
  final int discount;
  final int stock;
  final String productid;
  CommonProductsListContainer(
      {Key? key,
      required this.stock,
      required this.imageUrl,
      required this.mrp,
      required this.productName,
      required this.productid,
      required this.uid,
      required this.discount});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: darkGrey50Color,
              width: 0.5,
            ),
            top: BorderSide(
              color: darkGrey50Color,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Center(
              child: Container(
                width: 180,
                height: 230,
                decoration: BoxDecoration(
                  color: lightGray25Color,
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    width: 160,
                    height: 61,
                    decoration: BoxDecoration(),
                    child: Image.network(
                      imageUrl,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: screenWidth - 210,
              margin: const EdgeInsets.only(left: 10, right: 20, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: "LexendRegular",
                      color: black90Color,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Row(
                      children: [
                        Text(
                          '₹ ${NumberFormat('#,##,###').format((mrp - (mrp * discount / 100)))}',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: "LexendRegular",
                            color: blackColor,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'M.R.P ₹ ${NumberFormat('#,##,###').format(mrp)}',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: "LexendRegular",
                              color: black50Color,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: black50Color,
                              decorationStyle: TextDecorationStyle.solid),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Row(
                      children: [
                        Text(
                          '(save ₹ ${NumberFormat('#,##,###').format(mrp - (mrp - (mrp * discount / 100)))})',
                          style: TextStyle(
                              color: darkBlueColor,
                              fontFamily: "LexendRegular",
                              fontSize: 14),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(discount.toString() + "% off",
                            style: TextStyle(
                                color: brownColor,
                                fontFamily: "LexendRegular",
                                fontSize: 16)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GeneralProductCartBtn(
                     stock: stock,
                      img: imageUrl,
                      title: productName,
                      uid: uid,
                      productid: productid),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
