import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/SingleWidgets/ServiceAddBtn.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GeneralServiceContentContainer extends StatelessWidget {
  final List<dynamic>? Benefits;
  final String Images;
  final String Title;
  final int MRP;
    final int discount;

  final String uid;
  final String serviceid;
  final String category;

  GeneralServiceContentContainer({
    required this.Benefits,
    required this.Images,
    required this.Title,
    required this.MRP,
    required this.discount,
    required this.serviceid,
    required this.uid,
    required this.category,
  });

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
                        Title,
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
                              text:
                          '₹ ${NumberFormat('#,##,###').format((MRP - (MRP * discount / 100)))}  ',
                              style: TextStyle(
                                fontFamily: "LexendRegular",
                                fontSize: 20,
                                color: blackColor,
                              ),
                            ),
                            TextSpan(
                              text: '${NumberFormat('#,##,###').format(MRP)}',
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
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: Benefits?.length ?? 0,
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
                                        text: Benefits![index],
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
                          Images, // Use Image.network instead of NetworkImage
                          width: 120,
                          height: 160,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(top: 155, child: ServiceAddBtn(title: Title,uid: uid,serviceid: serviceid,category: category,)),
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
          ),
        ],
      ),
    );
  }
}
