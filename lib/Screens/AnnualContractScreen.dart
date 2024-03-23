import 'package:acbaradise/Models/DataBaseHelper.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/AMCCategorySelection.dart';
import 'package:acbaradise/Widgets/SingleWidgets/AppbarWithCart.dart';
import 'package:acbaradise/Widgets/SingleWidgets/ServicePageBanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:acbaradise/Widgets/CombinedWidgets/AnnualSchemeContainer.dart';

class AnnualContractScreen extends StatefulWidget {
  final String uid;
  AnnualContractScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<AnnualContractScreen> createState() => _AnnualContractScreenState();
}

class _AnnualContractScreenState extends State<AnnualContractScreen> {
  bool isLoading = false; // Flag to track loading state

  final GlobalKey splitACKey = GlobalKey();
  final GlobalKey windowACKey = GlobalKey();
  final GlobalKey cassetteACKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppbarWithCart(
        PageName: "AMC",
        iscart: true,
        uid: widget.uid,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: DatabaseHelper.getAMCImg(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: darkBlueColor,
                strokeWidth: 2,
              ), // Display loading indicator conditionally
            );
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

         if (snapshot.data == null || !snapshot.data!.exists) {
            return Center(
              child: Text('Services not available right now'),
            );
          }

          var AMCof = snapshot.data!;
          String splitACimg = AMCof["SplitACIMG"] ?? '';
          String windowACimg = AMCof["WindowACIMG"] ?? '';
          String cassetteACimg = AMCof["CassetteACIMG"] ?? '';
          String bannerURL = AMCof["BannerUrl"] ?? '';
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ServicePageBanner(
                  Imageurl: bannerURL,
                ),
                const SizedBox(
                  height: 20,
                ),
                AMCCategorySelection(
                    splitACimg: splitACimg,
                    windowACimg: windowACimg,
                    cassetteACimg: cassetteACimg,
                    fun: () => onTapCallback()
                    ),
               
                SplitACAnnualSchemeContainer(
                  key: splitACKey,
                  uid: widget.uid,
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void onTapCallback() {
    Scrollable.ensureVisible(
      splitACKey.currentContext!,
      alignment: 0.01,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}

class SplitACAnnualSchemeContainer extends StatelessWidget {
  final String uid;

  const SplitACAnnualSchemeContainer({Key? key, required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseHelper.getSplitACCollection(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(); // Placeholder for loading state
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Expanded(child: Text('Services not available right now')),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var Schemes = snapshot.data!.docs[index];

            Map<String, dynamic> contentMap = Schemes['Content'];
            String content = contentMap['OverviewContent'] ?? '';
            String title = contentMap['Title'] ?? '';
            List<dynamic>? images = contentMap['Images'];
            List<dynamic>? benefits = contentMap['Benefits'];
            int discount = contentMap['Discount'] ?? 0;

            List<dynamic>? totalSpares = contentMap['TotalSpares'];
            int totalSparesmrp = contentMap['TotalSparesMRP'];
            int mrp = contentMap['MRP'] ?? 0;
            String serviceid = Schemes.id.toString() ?? '';

            return AnnualSchemeContainer(
              title: title,
              mrp: mrp,
              content: content,
              images: images,
              benefits: benefits,
              TotalSparesContent: totalSpares,
              TotalSparesMRP: totalSparesmrp,
              uid: uid,
              discount: discount,
              Serviceid: serviceid,
            );
          },
          itemCount: snapshot.data!.docs.length,
        );
      },
    );
  }
}
