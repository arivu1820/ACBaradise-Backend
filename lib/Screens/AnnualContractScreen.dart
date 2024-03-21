import 'package:acbaradise/Models/DataBaseHelper.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/SingleWidgets/AppbarWithCart.dart';
import 'package:acbaradise/Widgets/SingleWidgets/ServicePageBanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:acbaradise/Widgets/SingleWidgets/AnnualACCard.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/AnnualSchemeContainer.dart';

class AnnualContractScreen extends StatefulWidget {
  final String uid;
  AnnualContractScreen({super.key,required this.uid});

  @override
  State<AnnualContractScreen> createState() => _AnnualContractScreenState();
}

class _AnnualContractScreenState extends State<AnnualContractScreen> {
  bool issplit = true;

  bool iswindow = false;

  bool iscassette = false;

  final GlobalKey splitACKey = GlobalKey();

  final GlobalKey windowACKey = GlobalKey();

  final GlobalKey cassetteACKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppbarWithCart(PageName: "Annual Contract", iscart: true,uid: widget.uid,),
        body: StreamBuilder<DocumentSnapshot>(
          stream: DatabaseHelper.getAMCImg(),
          builder: (context, Snapshot) {
            if (Snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (Snapshot.hasError) {
              return Text('Error: ${Snapshot.error}');
            }

            var AMCof = Snapshot.data!;
            String splitACimg =
                AMCof["SplitACIMG"]; // Assuming you want the first product
            String windowACimg = AMCof["WindowACIMG"];
            String CassetteACimg = AMCof["CassetteACIMG"];
            String bannerURL = AMCof["BannerUrl"];
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ServicePageBanner(
                      Imageurl: bannerURL,
                    ),
                    const SizedBox(height: 20,),
                  Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => {
                              setState(() {
                                issplit = true;
                                iswindow = false;
                                iscassette = false;
                              }),
                              onTapCallback(splitACKey),
                            },
                            child: AnnualACCard(
                              condition: issplit,
                              name: "Split AC",
                              img: splitACimg,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () => {
                              setState(() {
                                issplit = false;
                                iswindow = true;
                                iscassette = false;
                              }),
                              onTapCallback(windowACKey),
                            },
                            child: AnnualACCard(
                              condition: iswindow,
                              name: "Window AC",
                              img: windowACimg,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () => {
                              setState(() {
                                issplit = false;
                                iswindow = false;
                                iscassette = true;
                              }),
                              onTapCallback(cassetteACKey),
                            },
                            child: AnnualACCard(
                              condition: iscassette,
                              name: "Cassette AC",
                              img: CassetteACimg,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SplitACAnnualSchemeContainer(key: splitACKey,uid: widget.uid,),
                  WindowACAnnualSchemeContainer(key: windowACKey,uid: widget.uid,),
                  CassetteACAnnualSchemeContainer(key: cassetteACKey,uid: widget.uid,),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            );
          },
        ));
  }
}

class CassetteACAnnualSchemeContainer extends StatelessWidget {
    final String uid;

  const CassetteACAnnualSchemeContainer({
    super.key,
    required this.uid
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseHelper.getCassetteACCollection(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Placeholder for loading state
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        // Use the snapshot.data to build your widget
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
            List<dynamic>? totalSpares = contentMap['TotalSpares'];
            int totalSparesmrp = contentMap['TotalSparesMRP'];
            int discount = contentMap['Discount'] ?? 0;
            int mrp = contentMap['MRP'] ?? 0;
            String serviceid = Schemes.id.toString() ?? '';

            return AnnualSchemeContainer(
              title: title,
              discount:discount,
              mrp: mrp,
              content: content,
              images: images,
              benefits: benefits,
              TotalSparesContent: totalSpares,
              TotalSparesMRP: totalSparesmrp,
              Serviceid: serviceid,
              uid: uid,
            );
          },
          itemCount: snapshot.data!.docs.length,
        );
      },
    );
  }
}

class WindowACAnnualSchemeContainer extends StatelessWidget {
    final String uid;

  const WindowACAnnualSchemeContainer({
    super.key,
    required this.uid
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseHelper.getWindowACCollection(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Placeholder for loading state
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        // Use the snapshot.data to build your widget
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var Schemes = snapshot.data!.docs[index];

            Map<String, dynamic> contentMap = Schemes['Content'];
            String content = contentMap['OverviewContent'] ?? '';
            String title = contentMap['Title'] ?? '';
            List<dynamic>? images = contentMap['Images'];
                        int discount = contentMap['Discount'] ?? 0;

            List<dynamic>? benefits = contentMap['Benefits'];
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
              uid:  uid,
              Serviceid:serviceid ,
              discount: discount,
            );
          },
          itemCount: snapshot.data!.docs.length,
        );
      },
    );
  }
}

class SplitACAnnualSchemeContainer extends StatelessWidget {
    final String uid;

  const SplitACAnnualSchemeContainer({
    Key? key,
    required this.uid
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace `yourDataStream` with your actual stream of data
    return StreamBuilder(
      stream: DatabaseHelper.getSplitACCollection(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Placeholder for loading state
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        // Use the snapshot.data to build your widget
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
              uid:  uid,
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

void onTapCallback(GlobalKey key) {
  if (key.currentContext != null) {
    Scrollable.ensureVisible(
      key.currentContext!,
      alignment: 0.01,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
