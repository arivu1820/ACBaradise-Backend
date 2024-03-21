
import 'package:acbaradise/Screens/AnnualContractScreen.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/SingleWidgets/ServicesContainer.dart';
import 'package:flutter/material.dart';

class AllServicesContainer extends StatelessWidget {
  final Function(GlobalKey) callgeneralServiceKey;
  final Function(GlobalKey) callwetwashKey;
  final Function(GlobalKey) callrepairKey;
  final Function(GlobalKey) callinstalluninstallKey;
  final GlobalKey generalServiceKey;
  final GlobalKey wetWashKey;
  final GlobalKey repairKey;
  final String uid;

  final GlobalKey installUninstallKey;
  final List<Map<String, dynamic>> serviceDataList;

  const AllServicesContainer(
      {super.key,
      required this.callgeneralServiceKey,
      required this.callwetwashKey,
      required this.callrepairKey,
      required this.callinstalluninstallKey,
      required this.generalServiceKey,
      required this.wetWashKey,
      required this.repairKey,
      required this.installUninstallKey,
      required this.serviceDataList,
      required this.uid});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => callgeneralServiceKey(generalServiceKey),
                      child: ServicesContainer(
                        serviceName: serviceDataList[0]['serviceName'],
                        imageUrl: serviceDataList[0]['imageUrl'],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () => callwetwashKey(wetWashKey),
                      child: ServicesContainer(
                        serviceName: serviceDataList[1]['serviceName'],
                        imageUrl: serviceDataList[1]['imageUrl'],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => callrepairKey(repairKey),
                      child: ServicesContainer(
                        serviceName: serviceDataList[2]['serviceName'],
                        imageUrl: serviceDataList[2]['imageUrl'],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () => callinstalluninstallKey(installUninstallKey),
                      child: ServicesContainer(
                        serviceName: serviceDataList[3]['serviceName'],
                        imageUrl: serviceDataList[3]['imageUrl'],
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AnnualContractScreen(uid: uid,)),
                );
              },
              child: Container(
                height: 210,
                width: 170,
                decoration: BoxDecoration(
                    color: darkBlue10Color,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 20),
                      child: Text(
                        serviceDataList[4]['serviceName'],
                        style: TextStyle(
                          fontFamily: "LexendMedium",
                          fontSize: 16,
                          color: blackColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      child: Container(
                        child: Image.asset("Assets/Icons/Serviceman_Img.png"
                        ),
                        height: 130,
                        width: 170,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
