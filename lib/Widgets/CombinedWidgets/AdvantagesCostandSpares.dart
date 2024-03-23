import 'package:acbaradise/Models/DataBaseHelper.dart';
import 'package:acbaradise/Screens/MyCartScreen.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/AMCAdvantages.dart';
import 'package:acbaradise/Widgets/SingleWidgets/AMCTotalSparesContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class AdvantagesCostandSpares extends StatefulWidget {
  final int discount;
  final int mrp;
  final int TotalSparesMRP;
  final List<dynamic>? TotalSparesContent;
  final String uid;
  final String Serviceid;
  final String Servicetitle;

  AdvantagesCostandSpares(
      {super.key,
      required this.mrp,
      required this.discount,
      required this.TotalSparesContent,
      required this.TotalSparesMRP,
      required this.Serviceid,
      required this.Servicetitle,
      required this.uid});

  @override
  State<AdvantagesCostandSpares> createState() =>
      _AdvantagesCostandSparesState();
}

class _AdvantagesCostandSparesState extends State<AdvantagesCostandSpares> {
  bool isTapped = false;
  bool isSelected = true;

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
        .collection('AMCCart')
        .get();

    bool productFound = cartSnapshot.docs.any((doc) => doc.id == widget.Serviceid);

    if (productFound) {
      // If product is found, get the document corresponding to the service ID
      var productDoc = cartSnapshot.docs.firstWhere((doc) => doc.id == widget.Serviceid);
      
      // Check the value of 'UseTotalSpares' field in the document
      isSelected = productDoc['UseTotalSpares']; // Default to false if 'UseTotalSpares' doesn't exist or is null
    }

    setState(() {
      isProductInCart = productFound;
      isSelected = isSelected;
    });
  } catch (error) {
    print('Error checking product in cart: $error');
  }
}


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: isTapped ? 200 : 60,
          width: double.infinity,
          color: opplightBlue10Color,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        "Total spares can be added",
                        style: const TextStyle(
                            fontFamily: "LexendMedium",
                            fontSize: 16,
                            color: blackColor),
                      ),
                    ),
                    Expanded(
                        child: const SizedBox(
                      width: 10,
                    )),
                    GestureDetector(
                      onTap: isProductInCart
                          ? () {}
                          : () => setState(() {
                                isSelected = !isSelected;
                              }),
                      child: isSelected
                          ? Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: darkBlueColor)),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Image.asset(
                                  "Assets/Icons/checked.png",
                                  width: 30,
                                  height: 30,
                                  color: darkBlueColor,
                                ),
                              ),
                            )
                          : Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: darkBlueColor)),
                            ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isTapped = !isTapped;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: isTapped
                            ? Image.asset(
                                "Assets/Icons/Arrow_2.png",
                                width: 20,
                                height: 20,
                              )
                            : Image.asset(
                                "Assets/Icons/ArrowRight.png",
                                width: 20,
                                height: 20,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              if (isTapped)
                AMCTotalSparesContainer(
                  TotalSparesContent: widget.TotalSparesContent,
                )
            ],
          ),
        ),
        Container(
          color: whiteColor,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                color: whiteColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: const SizedBox()),
                        Text(
                          '${widget.discount} % off',
                          style: const TextStyle(
                              fontFamily: "LexendRegular",
                              fontSize: 18,
                              color: darkBlueColor),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            isSelected
                                ? '₹ ${NumberFormat('#,##,###').format(((widget.mrp + widget.TotalSparesMRP) - ((widget.mrp + widget.TotalSparesMRP) * widget.discount / 100)).ceilToDouble())}  '
                                : '₹ ${NumberFormat('#,##,###').format((widget.mrp - (widget.mrp * widget.discount / 100)).ceilToDouble())}  ',
                            style: const TextStyle(
                                fontFamily: "LexendMedium",
                                fontSize: 30,
                                color: blackColor),
                          ),
                        ),
                        Text(
                          isSelected
                              ? '₹ ${NumberFormat('#,##,###').format(widget.mrp + widget.TotalSparesMRP)}'
                              : '₹ ${NumberFormat('#,##,###').format(widget.mrp)}',
                          style: const TextStyle(
                              fontFamily: "LexendLight",
                              decoration: TextDecoration.lineThrough,
                              fontSize: 18,
                              color: blackColor),
                        ),
                      ],
                    )
                  ],
                ),
                width: 180,
                height: 100,
              ),
              Expanded(
                  child: GestureDetector(
                onTap: isProductInCart
                    ? () {}
                    : () async {
                        String uid = widget.uid;
                        Map<String, dynamic> productDetails = {
                          'count': 1,
                          'UseTotalSpares': isSelected
                        };

                        try {
                          await DatabaseHelper.addToAMCCart(
                            uid: uid,
                            productId: widget.Serviceid,
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
                      },
                child: isProductInCart
                    ? GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyCartScreen(uid: widget.uid),
                          ),
                        ),
                        child: Container(
                          height: 100,
                          color: lightBlueColor,
                          child: Center(
                              child: Text(
                            "Go To Cart",
                            style: const TextStyle(
                                fontFamily: "LexendMedium",
                                fontSize: 16,
                                color: blackColor),
                          )),
                        ),
                      )
                    : Container(
                        height: 100,
                        color: darkBlueColor,
                        child: Center(
                            child: Text(
                          "Add To Cart",
                          style: const TextStyle(
                              fontFamily: "LexendMedium",
                              fontSize: 16,
                              color: blackColor),
                        )),
                      ),
              ))
            ],
          ),
          height: 100,
          width: double.infinity,
        )
      ],
    );
  }
}
