import 'package:acbaradise/Models/CostContainerdatabase.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/AMCInCart.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/GeneralProductsInCart.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/ProductsInCart.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/ServicesInCard.dart';
import 'package:acbaradise/Widgets/SingleWidgets/AppbarWithCart.dart';
import 'package:acbaradise/Widgets/SingleWidgets/CenterProgressBar.dart';
import 'package:acbaradise/Widgets/SingleWidgets/ContinueToPaymentBtn.dart';
import 'package:acbaradise/Widgets/SingleWidgets/MyCartBanner.dart';
import 'package:acbaradise/Widgets/SingleWidgets/SelectAnAddress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyCartScreen extends StatefulWidget {
  final String uid;

  const MyCartScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  bool progressbar = false;

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar:
          AppbarWithCart(PageName: "My Cart", iscart: false, uid: widget.uid),
      body: progressbar
          ? CenterProgressBar()
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        MyCartBanner(page: 'MyCartPage',),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 30, right: 40, left: 40, bottom: 30),
                          child: Center(
                            child: Text(
                              "Add products and services to avail multiple discounts!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'LexendRegular',
                                fontSize: 14,
                                color: leghtGreen,
                              ),
                            ),
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Users')
                              .doc(widget.uid)
                              .collection('ProductsCart')
                              .snapshots(),
                          builder: (context, productSnapshot) {
                            if (productSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }

                            if (productSnapshot.hasData &&
                                productSnapshot.data!.docs.isNotEmpty) {
                              return ProductsInCart(
                                  isQtyReq: false, uid: widget.uid);
                            } else {
                              return Container();
                            }
                          },
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Users')
                              .doc(widget.uid)
                              .collection('GeneralProductsCart')
                              .snapshots(),
                          builder: (context, productSnapshot) {
                            if (productSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }

                            if (productSnapshot.hasData &&
                                productSnapshot.data!.docs.isNotEmpty) {
                              return GeneralProductsInCart(
                                  isQtyReq: false, uid: widget.uid);
                            } else {
                              return Container();
                            }
                          },
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Users')
                              .doc(widget.uid)
                              .collection('ServicesCart')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }

                            if (snapshot.hasData &&
                                snapshot.data!.docs.isNotEmpty) {
                              return ServicesInCart(
                                  isQtyReq: false, uid: widget.uid);
                            } else {
                              return Container();
                            }
                          },
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Users')
                              .doc(widget.uid)
                              .collection('AMCCart')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }

                            if (snapshot.hasData &&
                                snapshot.data!.docs.isNotEmpty) {
                              return AMCInCart(
                                  isQtyReq: false, uid: widget.uid);
                            } else {
                              return Container();
                            }
                          },
                        ),
                        Container(
                          height: 10,
                          color: Colors.grey[200],
                          width: double.infinity,
                        ),
                        SelectAnAddress(uid: widget.uid),
                        CostContainerSection(uid: widget.uid),
                      ],
                    ),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: ContinueToPaymentSection(uid: widget.uid),
    );
  }
}

class CostContainerSection extends StatelessWidget {
  final String uid;

  const CostContainerSection({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 150),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: darkBlue50Color,
                offset: Offset(0, 0),
                blurRadius: 4.0,
                spreadRadius: 0,
              ),
            ],
            color: whiteColor,
          ),
          child: Column(
            children: [
              ProductCartDetails(uid: uid),
              GeneralProductsCartDetails(uid: uid),
              ServicesCartDetails(uid: uid),
              AMCCartDetails(uid: uid),
              DiscountDetails(uid: uid),
              const SizedBox(height: 10),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width - 60,
                color: lightGrayColor,
              ),
              const SizedBox(height: 10),
              ToPayDetails(uid: uid),
            ],
          ),
        ),
      ],
    );
  }
}

class ProductCartDetails extends StatelessWidget {
  final String uid;

  const ProductCartDetails({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('ProductsCart')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Some Problem occur please try after sometime!',
            textAlign: TextAlign.center,
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        List<DocumentSnapshot> productWidgets = [];

        for (var product in snapshot.data!.docs) {
          productWidgets.add(product);
        }

        return FutureBuilder<Map<String, dynamic>>(
          future: CostContainerDatabase.fetchCategoriesDetails(productWidgets),
          builder: (context, categoriesSnapshot) {
            if (categoriesSnapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            Map<String, dynamic> categoriesDetails = categoriesSnapshot.data!;
            num totalPrice = categoriesDetails["totalPrice"] ?? 0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
                    const SizedBox(width: 10),
                    Text(
                      '₹ ${NumberFormat('#,##,##0.00').format(totalPrice)}  ',
                      style: TextStyle(
                        fontFamily: 'LexendLight',
                        fontSize: 14,
                        color: blackColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        );
      },
    );
  }
}

class GeneralProductsCartDetails extends StatelessWidget {
  final String uid;

  const GeneralProductsCartDetails({Key? key, required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('GeneralProductsCart')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Some Problem occur please try after sometime!',
            textAlign: TextAlign.center,
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        List<DocumentSnapshot> generalProductWidgets = [];

        for (var product in snapshot.data!.docs) {
          generalProductWidgets.add(product);
        }

        return FutureBuilder<Map<String, dynamic>>(
          future: CostContainerDatabase.fetchGeneralProductsDetails(
              generalProductWidgets),
          builder: (context, categoriesSnapshot) {
            if (categoriesSnapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            Map<String, dynamic> categoriesDetails = categoriesSnapshot.data!;
            num totalPrice = categoriesDetails["totalPrice"] ?? 0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
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
                    const SizedBox(width: 10),
                    Text(
                      '₹ ${NumberFormat('#,##,##0.00').format(totalPrice)}  ',
                      style: TextStyle(
                        fontFamily: 'LexendLight',
                        fontSize: 14,
                        color: blackColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        );
      },
    );
  }
}

class ServicesCartDetails extends StatelessWidget {
  final String uid;

  const ServicesCartDetails({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('ServicesCart')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        List<DocumentSnapshot> servicesWidgets = [];

        for (var service in snapshot.data!.docs) {
          servicesWidgets.add(service);
        }

        return FutureBuilder<Map<String, dynamic>>(
          future: CostContainerDatabase.fetchserviceCategoriesDetails(
              servicesWidgets),
          builder: (context, categoriesSnapshot) {
            if (categoriesSnapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            Map<String, dynamic> categoriesDetails = categoriesSnapshot.data!;
            num totalPrice = categoriesDetails["totalPrice"] ?? 0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Services",
                        style: TextStyle(
                          fontFamily: 'LexendLight',
                          fontSize: 14,
                          color: blackColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '₹ ${NumberFormat('#,##,##0.00').format(totalPrice)}  ',
                      style: TextStyle(
                        fontFamily: 'LexendLight',
                        fontSize: 14,
                        color: blackColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        );
      },
    );
  }
}

class AMCCartDetails extends StatelessWidget {
  final String uid;

  const AMCCartDetails({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('AMCCart')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        List<DocumentSnapshot> AMCWidgets = [];

        for (var AMC in snapshot.data!.docs) {
          AMCWidgets.add(AMC);
        }

        return FutureBuilder<Map<String, dynamic>>(
          future: CostContainerDatabase.fetchamcCategoriesDetails(AMCWidgets),
          builder: (context, categoriesSnapshot) {
            if (categoriesSnapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            Map<String, dynamic> categoriesDetails = categoriesSnapshot.data!;
            num totalPrice = categoriesDetails["totalPrice"] ?? 0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "AMC",
                        style: TextStyle(
                          fontFamily: 'LexendLight',
                          fontSize: 14,
                          color: blackColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '₹ ${NumberFormat('#,##,##0.00').format(totalPrice)}  ',
                      style: TextStyle(
                        fontFamily: 'LexendLight',
                        fontSize: 14,
                        color: blackColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        );
      },
    );
  }
}

class DiscountDetails extends StatelessWidget {
  final String uid;

  const DiscountDetails({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "Savings",
            style: TextStyle(
              fontFamily: 'LexendLight',
              fontSize: 14,
              color: leghtGreen,
            ),
          ),
        ),
        const SizedBox(width: 10),
        FutureBuilder<Map<String, dynamic>>(
          future: CostContainerDatabase.getTotalDiscount(uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("0");
            } else {
              return Text(
                '₹ ${NumberFormat('#,##,##0.00').format(snapshot.data!['totaldiscount'])}  ',
                style: TextStyle(
                  fontFamily: 'LexendLight',
                  fontSize: 14,
                  color: leghtGreen,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class ToPayDetails extends StatelessWidget {
  final String uid;

  const ToPayDetails({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "To Pay",
            style: TextStyle(
              fontFamily: 'LexendLight',
              fontSize: 14,
              color: blackColor,
            ),
          ),
        ),
        FutureBuilder<Map<String, dynamic>>(
          future: CostContainerDatabase.getTotalDiscount(uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("0");
            } else {
              return Text(
                '₹ ${NumberFormat('#,##,##0.00').format(snapshot.data!['totalprice'])}  ',
                style: TextStyle(
                  fontFamily: 'LexendLight',
                  fontSize: 14,
                  color: blackColor,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class ContinueToPaymentSection extends StatelessWidget {
  final String uid;

  const ContinueToPaymentSection({Key? key, required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: CostContainerDatabase.getTotalDiscount(uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: darkBlueColor,strokeWidth: 2,),);
        } else if (snapshot.hasError) {
          return Text("Try after some time");
        } else {
          return ContinueToPayment(
            uid: uid,
            totalprice: snapshot.data!['totalprice'],
            allserviceproductdetails: snapshot.data!['allserviceproduct'],
          );
        }
      },
    );
  }
}
