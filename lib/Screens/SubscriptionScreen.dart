import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/SubscriptionScheme.dart';
import 'package:acbaradise/Widgets/SingleWidgets/AppbarWithCart.dart';
import 'package:flutter/material.dart';

class SubscriptionScreen extends StatelessWidget {
  final String uid;
  SubscriptionScreen({required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWithCart(
        PageName: "Annual Contract Subscription",
        iscart: true,
        uid: uid,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(uid)
                  .collection('AMC Subscription')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // or any loading indicator
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                // If the data is not available, you can show a placeholder
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Text('No data available');
                }

                // If data is available, use ListView.builder
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var document = snapshot.data!.docs[index];
                    // Pass the document to SubscriptionScheme
                    return SubscriptionScheme(uid: uid, document: document);
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 30,)
        ],
      ),
    );
  }
}
