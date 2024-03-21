import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/SingleWidgets/ServiceAddBtn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WetWashContentContainer extends StatefulWidget {
  final String title;
  final int mrp;
  final List<dynamic>? benefits;
  final bool is360degree;
  final String Images;
  final int wash360mrp;
  final int discount;
  final String uid;
  final String serviceid;
  final String category;

  WetWashContentContainer(
      {required this.title,
      required this.mrp,
      required this.discount,
      required this.benefits,
      required this.is360degree,
      required this.Images,
      required this.wash360mrp,
      required this.serviceid,
      required this.category,
      required this.uid});

  @override
  State<WetWashContentContainer> createState() =>
      _WetWashContentContainerState();
}

class _WetWashContentContainerState extends State<WetWashContentContainer> {
  bool isSelected = true;
  bool iscounted = false;

  @override
  void initState() {
    super.initState();
    checkserviceInCart();
  }

  Future<void> checkserviceInCart() async {
    try {
      DocumentSnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.uid)
          .collection('ServicesCart')
          .doc(widget.serviceid)
          .get();

      if (cartSnapshot.exists) {
        // If the document exists, fetch the count value
        int fetchedCount = cartSnapshot['count'] ?? 0;
        bool is360degree = cartSnapshot['is360degree'];

        // Update the local count and added variable
        setState(() {
          iscounted = fetchedCount > 0;
          isSelected = is360degree;
        });
      } else {
        // If the document doesn't exist, set added to false
        setState(() {
          iscounted = false;
        });
      }
    } catch (error) {
      print('Error checking service in cart: $error');
    }
  }

  Widget _360degree() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                checkserviceInCart();

                if (!iscounted) {
                  setState(() {
                    isSelected = !isSelected;
                  });
                } else {
                  const snackdemo = SnackBar(
                    content:
                        Text("Cannot add 360-degree normal wash together!"),
                    backgroundColor: darkBlueColor,
                    elevation: 10,
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(5),
                    duration: Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();

                  ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                }
              },
              child: isSelected
                  ? Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: darkBlueColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Image.asset(
                          "Assets/Icons/checked.png",
                          width: 20,
                          height: 20,
                          color: darkBlueColor,
                        ),
                      ),
                    )
                  : Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(width: 1, color: darkBlueColor),
                      ),
                    ),
            ),
            const SizedBox(width: 10),
            Text(
              "Wash in 360 degree",
              style: TextStyle(
                fontFamily: "OxygenBold",
                fontSize: 12,
                color: blackColor,
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontFamily: "LexendRegular",
                          fontSize: 14,
                          color: blackColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: isSelected
                                  ? '₹ ${NumberFormat('#,##,###').format(((widget.mrp+ widget.wash360mrp) - ((widget.mrp+ widget.wash360mrp) * widget.discount / 100)) )}  '
                                  : '₹ ${NumberFormat('#,##,###').format((widget.mrp - (widget.mrp * widget.discount / 100)))}  ',
                              style: TextStyle(
                                fontFamily: "LexendRegular",
                                fontSize: 20,
                                color: blackColor,
                              ),
                            ),
                            TextSpan(
                              text: isSelected
                                  ? '₹ ${NumberFormat('#,##,###').format(widget.mrp +widget.wash360mrp)}  '
                                  : '₹ ${NumberFormat('#,##,###').format(widget.mrp )}  ',
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontFamily: "LexendRegular",
                                fontSize: 14,
                                color: black50Color,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (widget.is360degree) _360degree(),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.benefits!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontFamily: "OxygenRegular",
                                      fontSize: 12,
                                      color: blackColor,
                                    ),
                                    children: [
                                      WidgetSpan(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4.0),
                                          child: Text('•',
                                              style: TextStyle(fontSize: 12)),
                                        ),
                                      ),
                                      TextSpan(
                                        text: widget.benefits![index],
                                        style: TextStyle(
                                          fontFamily: "OxygenRegular",
                                          fontSize: 12,
                                          color: blackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 20),
                height: 200,
                child: Stack(
                  alignment: Alignment.center, // Center horizontally
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: lightBlue30Color,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            5), // Same as the container's border radius
                        child: Image.network(
                          widget
                              .Images, // Use Image.network instead of NetworkImage
                          width: 120,
                          height: 160,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                        top: 155,
                        child: ServiceAddBtn(
                          title: widget.title,
                          uid: widget.uid,
                          serviceid: widget.serviceid,
                          is360degree: isSelected,
                          category: widget.category,
                        )),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 50,
              ),
              Expanded(
                child: Divider(
                  thickness: 0.5,
                  color: lightGrayColor,
                ),
              ),
              const SizedBox(
                width: 50,
              ),
            ],
          )
        ],
      ),
    );
  }
}
