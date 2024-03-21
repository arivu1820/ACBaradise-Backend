import 'package:acbaradise/Screens/ACProductScreen.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/ProductsListContainer.dart';
import 'package:acbaradise/Widgets/SingleWidgets/AppbarWithCart.dart';
import 'package:acbaradise/Widgets/SingleWidgets/ContentFilerContioner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:acbaradise/Models/DataBaseHelper.dart';

class ProductListScreen extends StatefulWidget {
  final String CategoryName;
  final String CategoryId;
  final String uid;

  ProductListScreen(
      {required this.CategoryName,
      required this.CategoryId,
      required this.uid});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<bool> isSelectedList = [];
  List<String> SelectedTonsList = [];
  List<String> SelectedBrandsList = [];

  Stream<Map<String, List<dynamic>>> getTonsStream() {
    return DatabaseHelper.getTonsAndBrandsForCategory(widget.CategoryId);
  }

  Stream<QuerySnapshot> getProductStream() {
    return DatabaseHelper.getProductsForCategory(widget.CategoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppbarWithCart(
        PageName: widget.CategoryName,
        iscart: true,
        uid: widget.uid,
        isreplacepage: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<Map<String, List<dynamic>>>(
            stream: getTonsStream(),
            builder: (context, snapshot) {
              // if (snapshot.connectionState == ConnectionState.waiting) {
              //   return CircularProgressIndicator();
              // }
      
              if (snapshot.hasError) {
                return Container(
                  height: 80,
                  width: double.infinity,
                  color: whiteColor,
                );
              }
      
              Map<String, List<dynamic>> data =
                  snapshot.data ?? {'tons': [], 'brands': []};
              List<dynamic>? tons = data['tons'];
              List<dynamic>? brands = data['brands'];
      
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 20),
                      ...List.generate(tons!.length + brands!.length, (index) {
                        bool isSelected = isSelectedList.length > index &&
                            isSelectedList[index];
                        String content = index < tons!.length
                            ? tons![index].toString()
                            : brands![index - tons!.length].toString();
                        bool isTon = index < tons!.length;
      
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelectedList.length > index) {
                                isSelectedList[index] = !isSelectedList[index];
                              } else {
                                isSelectedList.addAll(List.filled(
                                    index + 1 - isSelectedList.length, false));
                                isSelectedList[index] = true;
                              }
      
                              if (isTon) {
                                // Handle tons selection
                                if (SelectedTonsList.contains(content)) {
                                  SelectedTonsList.remove(content);
                                } else {
                                  SelectedTonsList.add(content);
                                }
                              } else {
                                // Handle brands selection
                                if (SelectedBrandsList.contains(content)) {
                                  SelectedBrandsList.remove(content);
                                } else {
                                  SelectedBrandsList.add(content);
                                }
                              }
      
                              print(isSelectedList);
                              print(SelectedTonsList);
                              print(SelectedBrandsList);
                            });
                          },
                          child: ContentFilterContainer(
                            content: content,
                            isSelected: isSelected,
                            isTon: isTon,
                          ),
                        );
                      }),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              );
            },
          ),
          StreamBuilder<QuerySnapshot>(
            stream: getProductStream(),
            builder: (context, productSnapshot) {
              if (productSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: lightBlueColor,
                  ),
                );
              }
      
              if (productSnapshot.hasError) {
                return Center(
                  child: CircularProgressIndicator(
                    color: lightBlueColor,
                  ),
                );
              }
      
              if (productSnapshot.data!.docs.isEmpty) {
                return Text('No products found');
              }
      
              // If SelectedTonsList is empty, display all products
              if (SelectedTonsList.isEmpty && SelectedBrandsList.isEmpty) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: productSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var productDoc = productSnapshot.data!.docs[index];
                      String proName = productDoc['Name'];
                      List<dynamic>? images = productDoc['Images'];
                      String imageUrl =
                          images != null && images.isNotEmpty ? images[0] : '';
                      int mrp = productDoc['MRP'] ?? 0;
                      int discount = productDoc["Discount"] ?? 0;
                      int stock = productDoc['Stock'] ?? 0;
                      String productId = productDoc.id;
                      // String? uid = await DatabaseHelper.getUid();
      
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ACProductScreen(
                                ProductName: proName,
                                ProductId: productId,
                                CategoryId: widget.CategoryId,
                                uid: widget.uid,
                              ),
                            ),
                          );
                        },
                        child: ProductsListContainer(
                          productName: proName,
                          imageUrl: imageUrl,
                          discount: discount,
                          mrp: mrp,
                          productid: productId,
                          uid: widget.uid,
                          stock: stock,
                        ),
                      );
                    },
                  ),
                );
              } else {
                // If SelectedTonsList has values, display selected products first
                List<String> selectedTons = SelectedTonsList;
                List<String> selectedBrands = SelectedBrandsList;
      
                List<Widget> productListWidgets = [];
      
                for (var index = 0;
                    index < productSnapshot.data!.docs.length;
                    index++) {
                  var productDoc = productSnapshot.data!.docs[index];
                  String proName = productDoc['Name'];
                  String ton = productDoc['Ton'];
                  String brand = productDoc['Brand'];
                  List<dynamic>? images = productDoc['Images'];
                  String imageUrl =
                      images != null && images.isNotEmpty ? images[0] : '';
                  int mrp = productDoc['MRP'] ?? 0;
                  int discount = productDoc["Discount"] ?? 0;
      
                  int stock = productDoc['Stock'] ?? 0;
      
                  String productId = productDoc.id;
      
                  // If the product's ton matches any in the SelectedTonsList, add it to the selected products list
                  if (selectedTons.contains(ton) ||
                      selectedBrands.contains(brand)) {
                    productListWidgets.insert(
                      0,
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ACProductScreen(
                                ProductName: proName,
                                ProductId: productId,
                                CategoryId: widget.CategoryId,
                                uid: widget.uid,
                              ),
                            ),
                          );
                        },
                        child: ProductsListContainer(
                          productName: proName,
                          imageUrl: imageUrl,
                          discount: discount,
                          mrp: mrp,
                          productid: productId,
                          uid: widget.uid,
                          stock: stock,
                        ),
                      ),
                    );
                  } else {
                    productListWidgets.add(
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ACProductScreen(
                                ProductName: proName,
                                ProductId: productId,
                                CategoryId: widget.CategoryId,
                                uid: widget.uid,
                              ),
                            ),
                          );
                        },
                        child: ProductsListContainer(
                          productName: proName,
                          imageUrl: imageUrl,
                          discount: discount,
                          mrp: mrp,
                          productid: productId,
                          uid: widget.uid,
                          stock: stock,
                        ),
                      ),
                    );
                    // Remove the ton from the list to avoid duplicates
                  }
                }
      
                return Expanded(
                  child: ListView.builder(
                    itemCount: productListWidgets.length,
                    itemBuilder: (context, index) {
                      return productListWidgets[index];
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
