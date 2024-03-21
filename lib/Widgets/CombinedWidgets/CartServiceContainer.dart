import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/SingleWidgets/CardAddBtn.dart';
import 'package:acbaradise/Widgets/SingleWidgets/OrderPriceWithout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class CartServiceContainer extends StatelessWidget {
  final bool isQtyReq;
  final String uid;
  final String category;
  final List<Map<String, dynamic>> allServiceDetails;

  CartServiceContainer({
    Key? key,
    required this.isQtyReq,
    required this.allServiceDetails,
    required this.uid,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int itemCount = allServiceDetails.length;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            category,
            style: const TextStyle(
              fontFamily: "LexendMedium",
              fontSize: 15,
              color: blackColor,
            ),
          ),
          Row(
            children: [
              Container(
                height: itemCount * 100 - 30,
                child: DottedLine(
                  dashLength: 2.0,
                  lineLength: double.infinity,
                  direction: Axis.vertical,
                  dashColor: black50Color,
                  dashGapLength: 2.0,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    String title = allServiceDetails[index]['title'];
                    String productid = allServiceDetails[index]['serviceId'];
                    String servicedoc = allServiceDetails[index]['servicedoc'];
                    String servicecoll =
                        allServiceDetails[index]['servicecoll'];

                    
                    return Container(
                      margin: const EdgeInsets.only(left: 10, top: 20),
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
                          isQtyReq
                              ? OrderPriceWithout(orderamount: 2,count: 2,)
                              : CartAddBtn(
                                  productid: productid,
                                  uid: uid,
                                  collectionid: "ServicesCart",
                                  servicedoc: servicedoc,
                                  servicecoll: servicecoll,
                                ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
