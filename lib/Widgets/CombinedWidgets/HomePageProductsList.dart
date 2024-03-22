import 'package:acbaradise/Screens/ACProductScreen.dart';
import 'package:acbaradise/Screens/ProductListScreen.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/SingleWidgets/HomePageSeeMoreContainer.dart';
import 'package:flutter/material.dart';

class HomePageProductsList extends StatelessWidget {
  final String CategoryId;
  final String CategoryName;
  final List<String> ProductName;
  final List<String> ImageURL;
  final String uid;
  final List<String> proid;

  HomePageProductsList(
      {required this.CategoryId,
      required this.CategoryName,
      required this.proid,
      required this.ProductName,
      required this.ImageURL,
      required this.uid});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              CategoryName,
              style: const TextStyle(
                fontFamily: "LexendRegular",
                fontSize: 14,
                color: blackColor,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return index != 3
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            boxShadow: [
                              BoxShadow(
                                color: darkBlue25Color,
                                offset: Offset(0, 0),
                                blurRadius: 3.0,
                                spreadRadius: 0,
                              ),
                            ],
                            color: whiteColor,
                          ),
                          margin: EdgeInsets.only(
                              top: 5, bottom: 5, left: index == 0 ? 20 : 10),
                          height: 120,
                          width: 180,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ACProductScreen(
                                            ProductName: ProductName[index],
                                            ProductId: proid[index],
                                            CategoryId: CategoryId,
                                            uid: uid,
                                          ),
                                        ));
                                  },
                                  child: Container(
                                    width: 180,
                                    height: 90,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Image.network(ImageURL[index]),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  ProductName[index],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: "LexendRegular",
                                    fontSize: 11,
                                    color: blackColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductListScreen(
                                        CategoryName: CategoryName,
                                        CategoryId: CategoryId,
                                        uid: uid,
                                      )),
                            );
                          },
                          child: HomePageSeeMoreContainer());
                },
                itemCount: ProductName.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
