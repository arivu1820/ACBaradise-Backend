import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/CartServiceContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ServicesInCart extends StatelessWidget {
  final String uid;
  final bool isQtyReq;

  const ServicesInCart({Key? key, required this.isQtyReq, required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('ServicesCart')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        var services = snapshot.data!.docs;
        List<Map<String, dynamic>> allGeneralServiceDetails = [];
        List<Map<String, dynamic>> allWetWashDetails = [];
        List<Map<String, dynamic>> allRepairDetails = [];
        List<Map<String, dynamic>> allInstallUninstallDetails = [];

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Services",
                style: const TextStyle(
                  fontFamily: "Stylish",
                  fontSize: 18,
                  color: darkBlueColor,
                ),
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: Future.wait(
                  services.map((serviceDoc) async {
                    var serviceData = serviceDoc.data() as Map<String, dynamic>;
                    String serviceId = serviceDoc.id;

                    DocumentSnapshot serviceSnapshot = await FirebaseFirestore
                        .instance
                        .collection('Services')
                        .doc('hWHRjpawA5D6OTbrjn3h')
                        .collection('Categories')
                        .doc('1GeneralService')
                        .collection('GeneralService')
                        .doc(serviceId)
                        .get();

                    if (serviceSnapshot.exists) {
                      Map<String, dynamic> serviceDetails =
                          serviceSnapshot.data() as Map<String, dynamic>;

                      allGeneralServiceDetails.add({
                        'serviceId': serviceId,
                        'title': serviceDetails['Title'],
                        'count': serviceData['count'],
                        'servicedoc' : '1GeneralService',
                        'servicecoll' : 'GeneralService',
                      });
                    } 
                    

                    // Ensure a default return statement here
                    return {}; // You can modify this to an appropriate default value
                  }),
                ),
                builder: (context, serviceListSnapshot) {
                  if (serviceListSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (!serviceListSnapshot.hasData ||
                      serviceListSnapshot.data == null ||
                      allGeneralServiceDetails.isEmpty) {
                    return Container(); // or some default widget
                  }

                  return CartServiceContainer(
                    isQtyReq: isQtyReq,
                    uid: uid,
                    category: "General Service",
                    allServiceDetails: allGeneralServiceDetails,
                  );
                },
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: Future.wait(
                  services.map((serviceDoc) async {
                    var serviceData = serviceDoc.data() as Map<String, dynamic>;
                    String serviceId = serviceDoc.id;

                    DocumentSnapshot serviceSnapshot = await FirebaseFirestore
                        .instance
                        .collection('Services')
                        .doc('hWHRjpawA5D6OTbrjn3h')
                        .collection('Categories')
                        .doc('2WetWash')
                        .collection('WetWash')
                        .doc(serviceId)
                        .get();

                    if (serviceSnapshot.exists) {
                      Map<String, dynamic> serviceDetails =
                          serviceSnapshot.data() as Map<String, dynamic>;

                      allWetWashDetails.add({
                        'serviceId': serviceId,
                        'title': serviceDetails['Title'],
                        'count': serviceData['count'],
                        'servicedoc' : '2WetWash',
                        'servicecoll' : 'WetWash',
                      });
                    }

                    // Ensure a default return statement here
                    return {}; // You can modify this to an appropriate default value
                  }),
                ),
                builder: (context, serviceListSnapshot) {
                  if (serviceListSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (!serviceListSnapshot.hasData ||
                      serviceListSnapshot.data == null ||
                      allWetWashDetails.isEmpty) {
                    return Container(); // or some default widget
                  }

                  return CartServiceContainer(
                    isQtyReq: isQtyReq,
                    uid: uid,
                    category: "Wet Wash",
                    allServiceDetails: allWetWashDetails,
                  );
                },
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: Future.wait(
                  services.map((serviceDoc) async {
                    var serviceData = serviceDoc.data() as Map<String, dynamic>;
                    String serviceId = serviceDoc.id;

                    DocumentSnapshot serviceSnapshot = await FirebaseFirestore
                        .instance
                        .collection('Services')
                        .doc('hWHRjpawA5D6OTbrjn3h')
                        .collection('Categories')
                        .doc('3Repair')
                        .collection('Repair')
                        .doc(serviceId)
                        .get();

                    if (serviceSnapshot.exists) {
                      Map<String, dynamic> serviceDetails =
                          serviceSnapshot.data() as Map<String, dynamic>;

                      allRepairDetails.add({
                        'serviceId': serviceId,
                        'title': serviceDetails['Title'],
                        'count': serviceData['count'],
                        'servicedoc' : '3Repair',
                        'servicecoll' : 'Repair',
                      });
                    }

                    // Ensure a default return statement here
                    return {}; // You can modify this to an appropriate default value
                  }),
                ),
                builder: (context, serviceListSnapshot) {
                  if (serviceListSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (!serviceListSnapshot.hasData ||
                      serviceListSnapshot.data == null ||
                      allRepairDetails.isEmpty) {
                    return Container(); // or some default widget
                  }

                  return CartServiceContainer(
                    isQtyReq: isQtyReq,
                    uid: uid,
                    category: "Repair",
                    allServiceDetails: allRepairDetails,
                  );
                },
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: Future.wait(
                  services.map((serviceDoc) async {
                    var serviceData = serviceDoc.data() as Map<String, dynamic>;
                    String serviceId = serviceDoc.id;

                    DocumentSnapshot serviceSnapshot = await FirebaseFirestore
                        .instance
                        .collection('Services')
                        .doc('hWHRjpawA5D6OTbrjn3h')
                        .collection('Categories')
                        .doc('4InstallUninstall')
                        .collection('InstallUninstall')
                        .doc(serviceId)
                        .get();

                    if (serviceSnapshot.exists) {
                      Map<String, dynamic> serviceDetails =
                          serviceSnapshot.data() as Map<String, dynamic>;

                      allInstallUninstallDetails.add({
                        'serviceId': serviceId,
                        'title': serviceDetails['Title'],
                        'count': serviceData['count'],
                        'servicedoc' : '4InstallUninstall',
                        'servicecoll' : 'InstallUninstall',
                      });
                    }

                    

                    // Ensure a default return statement here
                    return {}; // You can modify this to an appropriate default value
                  }),
                ),
                
                builder: (context, serviceListSnapshot) {
                  if (serviceListSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }


                  

                  if (!serviceListSnapshot.hasData ||
                      serviceListSnapshot.data == null ||
                      allInstallUninstallDetails.isEmpty) {
                    
                    return Container(); // or some default widget
                  }

                  return CartServiceContainer(
                    isQtyReq: isQtyReq,
                    uid: uid,
                    category: "Install Uninstall",
                    allServiceDetails: allInstallUninstallDetails,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
