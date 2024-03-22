import 'package:acbaradise/Screens/ACProductScreen.dart';
import 'package:acbaradise/Screens/CommonProductScreen.dart';
import 'package:acbaradise/Screens/ProductListScreen.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/SingleWidgets/HomePageSeeMoreContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GeneralProductsList extends StatefulWidget {
  final String uid;

  GeneralProductsList({required this.uid});

  @override
  State<GeneralProductsList> createState() => _GeneralProductsListState();
}

class _GeneralProductsListState extends State<GeneralProductsList> {
  final String title = 'General Product';


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: 150,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('GeneralProducts')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // or a loading indicator
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    
                    return Container(); // Return an empty container if there's no data
                  }

                  List<DocumentSnapshot> documents = snapshot.data!.docs;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontFamily: "LexendRegular",
                            fontSize: 14,
                            color: blackColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            DocumentSnapshot document = documents[index];
                            String productName =
                                document['Name']; // Replace with your field name
                            String imageUrl =
                                document['Image']; // Replace with your field name
                            return index != 3
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CommonProductScreen(
                                                    ProductName: title, uid: widget.uid),
                                          ));
                                    },
                                    child: Container(
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
                                          top: 5,
                                          bottom: 5,
                                          left: index == 0 ? 20 : 10),
                                      height: 120,
                                      width: 180,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 180,
                                              height: 90,
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Image.network(imageUrl),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              productName,
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
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CommonProductScreen(
                                                    ProductName: title,
                                                    uid: widget.uid)),
                                      );
                                    },
                                    child: HomePageSeeMoreContainer());
                          },
                          itemCount: documents.length,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
