import 'package:acbaradise/Models/DataBaseHelper.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/AllServicesContainer.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/GeneralService.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/InstallUninstall.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/Repair.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/WetWash.dart';
import 'package:acbaradise/Widgets/SingleWidgets/AppbarWithCart.dart';
import 'package:acbaradise/Widgets/SingleWidgets/ServicePageBanner.dart';
import 'package:acbaradise/Widgets/SingleWidgets/ServicesForYouText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ServiceScreen extends StatelessWidget {
  final GlobalKey generalServiceKey = GlobalKey();
  final GlobalKey WetWashKey = GlobalKey();
  final GlobalKey RepairKey = GlobalKey();
  final GlobalKey InstallUninstallKey = GlobalKey();
  final String uid;

  ServiceScreen({required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppbarWithCart(PageName: "Service's", iscart: true,uid: uid,isreplacepage: true,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: DatabaseHelper.getServicesCollection(),
              builder: (context, serviceSnapshot) {
                if (serviceSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (serviceSnapshot.hasError) {
                  return Text('Error: ${serviceSnapshot.error}');
                }

                String bannerURL = serviceSnapshot.data!.docs[0]['BannerUrl'];
                String docid = serviceSnapshot.data!.docs[0].id;

                return Column(
                  children: [
                    ServicePageBanner(
                      Imageurl: bannerURL,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ServicesForYouText(),
                    StreamBuilder<QuerySnapshot>(
                      stream:
                          DatabaseHelper.getServicesCategoriesCollection(docid),
                      builder: (context, categorySnapshot) {
                        if (categorySnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        if (categorySnapshot.hasError) {
                          return Text('Error: ${categorySnapshot.error}');
                        }

                        List<Map<String, dynamic>> serviceDataList = [];

                        // Iterate through each document in the collection
                        categorySnapshot.data!.docs.forEach((doc) {
                          // Extract data from the document
                          String serviceName = doc['ServiceName'];
                          String imageUrl = doc['Image']; 

                          // Combine data into a map
                          Map<String, dynamic> serviceData = {
                            'serviceName': serviceName,
                            'imageUrl': imageUrl,
                          };

                          // Add the map to the list
                          serviceDataList.add(serviceData);
                        });

                        return Column(
                          children: [
                            AllServicesContainer(
                              callgeneralServiceKey: (key) {
                                onTapCallbackForService("General Service", key);
                              },
                              callwetwashKey: (key) {
                                onTapCallbackForService("Wet Wash", key);
                              },
                              callrepairKey: (key) {
                                onTapCallbackForService("Repair", key);
                              },
                              callinstalluninstallKey: (key) {
                                onTapCallbackForService(
                                    "Install Uninstall", key);
                              },
                              generalServiceKey: generalServiceKey,
                              wetWashKey: WetWashKey,
                              repairKey: RepairKey,
                              installUninstallKey: InstallUninstallKey,
                              serviceDataList: serviceDataList,
                              uid: uid,
                            ),
                            const SizedBox(
                              height: 20,
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
                            const SizedBox(
                              height: 10,
                            ),
                            GeneralService(
                              key: generalServiceKey,
                              docid: docid,
                              uid: uid,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            WetWash(
                              key: WetWashKey,
                              docid: docid,
                              uid: uid,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Repair(
                              key: RepairKey,
                              docid: docid,uid: uid,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InstallUninstall(
                              key: InstallUninstallKey,
                              docid: docid,uid: uid,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

void onTapCallbackForService(String serviceName, GlobalKey key) {
  if (key.currentContext != null) {
    Scrollable.ensureVisible(
      key.currentContext!,
      alignment: 0.01,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
