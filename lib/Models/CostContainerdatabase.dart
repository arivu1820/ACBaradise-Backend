import 'package:acbaradise/Widgets/CombinedWidgets/InstallUninstall.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/InstallUninstallContentContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/HomePageProductsList.dart';

class CostContainerDatabase {
  static Future<Map<String, dynamic>> fetchCategoriesDetails(
      List<DocumentSnapshot> generalproductWidgets) async {
    Map<String, dynamic> categoriesDetails = {};
    num totalPrice = 0;
    num totaldiscount = 0;
    List<Map<String, dynamic>> productDataList = [];

    // Iterate over each product document in 'ProductsCart' collection
    for (var product in generalproductWidgets) {
      String productId = product.id;
      int count = product["count"] ?? 0; // Get count value from 'ProductsCart'

      // Retrieve all documents from 'Categories' collection
      QuerySnapshot categoriesSnapshot =
          await FirebaseFirestore.instance.collection('Categories').get();

      // Iterate over each category document
      for (var categoryDoc in categoriesSnapshot.docs) {
        String categoryId = categoryDoc.id;

        // Retrieve the product document from 'Products' subcollection
        DocumentSnapshot productDoc = await FirebaseFirestore.instance
            .collection('Categories')
            .doc(categoryId)
            .collection('Products')
            .doc(productId)
            .get();

        // Check if the product document exists
        if (productDoc.exists) {
          // Store the product details in categoriesDetails map
          categoriesDetails[productId] = productDoc.data();

          productDataList.add({
            "productId": productId,
            "docId": categoryId,
            "productData": productDoc.data(),
            'count': count,
          });

          totaldiscount += (categoriesDetails[productId]['MRP'] ?? 0) * count -
              (categoriesDetails[productId]['MRP'] ?? 0) *
                  count *
                  (1 - (categoriesDetails[productId]['Discount'] ?? 0) / 100);

          // Add the Price value considering count and discount
          totalPrice += (categoriesDetails[productId]['MRP'] ?? 0) *
              count *
              (1 - (categoriesDetails[productId]['Discount'] ?? 0) / 100);
        }
      }
    }

    // Add the total price to the categoriesDetails map
    categoriesDetails["totalPrice"] = totalPrice;
    categoriesDetails['totalDiscount'] = totaldiscount;
    categoriesDetails["productDataList"] = productDataList;

    return categoriesDetails;
  }

  static Future<Map<String, dynamic>> fetchGeneralProductsDetails(
      List<DocumentSnapshot> generalproductWidgets) async {
    Map<String, dynamic> categoriesDetails = {};
    num totalPrice = 0;
    num totaldiscount = 0;
    List<Map<String, dynamic>> productDataList = [];

    // Iterate over each product document in 'ProductsCart' collection
    for (var product in generalproductWidgets) {
      String productId = product.id;
      int count = product["count"] ?? 0; // Get count value from 'ProductsCart'

      // Retrieve all documents from 'Categories' collection

      // Iterate over each category document

      // Retrieve the product document from 'Products' subcollection
      DocumentSnapshot productDoc = await FirebaseFirestore.instance
          .collection('GeneralProducts')
          .doc(productId)
          .get();

      // Check if the product document exists
      if (productDoc.exists) {
        // Store the product details in categoriesDetails map
        categoriesDetails[productId] = productDoc.data();

        productDataList.add({
          "productId": productId,
          "productData": productDoc.data(),
          'count': count,
        });

        totaldiscount += (categoriesDetails[productId]['MRP'] ?? 0) * count -
            (categoriesDetails[productId]['MRP'] ?? 0) *
                count *
                (1 - (categoriesDetails[productId]['Discount'] ?? 0) / 100);

        // Add the Price value considering count and discount
        totalPrice += (categoriesDetails[productId]['MRP'] ?? 0) *
            count *
            (1 - (categoriesDetails[productId]['Discount'] ?? 0) / 100);
      }
    }
    // Add the total price to the categoriesDetails map
    categoriesDetails["totalPrice"] = totalPrice;
    categoriesDetails['totalDiscount'] = totaldiscount;
    categoriesDetails["productDataList"] = productDataList;

    return categoriesDetails;
  }

  static Future<Map<String, dynamic>> fetchserviceCategoriesDetails(
    List<DocumentSnapshot> generalproductWidgets,
  ) async {
    Map<String, dynamic> categoriesDetails = {};
    List<String> docNames = [
      '1GeneralService',
      '2WetWash',
      '3Repair',
      '4InstallUninstall'
    ];
    List<String> subcollectionNames = [
      'GeneralService',
      'WetWash',
      'Repair',
      'InstallUninstall'
    ];
    num totalPrice = 0;
    num totaldiscount = 0;
    List<Map<String, dynamic>> productDataList = [];

    // Iterate over each product document in 'AMCCart' collection
    for (var product in generalproductWidgets) {
      String productId = product.id;
      int count = product["count"] ?? 0; // Get count value from 'AMCCart'

      // Iterate over each subcollection name
      for (int i = 0; i < subcollectionNames.length; i++) {
        String collectionName = subcollectionNames[i];
        String docName = docNames[i];

        // Retrieve the product document from the specified subcollection
        DocumentSnapshot productDoc = await FirebaseFirestore.instance
            .collection('Services')
            .doc('hWHRjpawA5D6OTbrjn3h')
            .collection('Categories')
            .doc(docName)
            .collection(collectionName)
            .doc(productId)
            .get();

        // Check if the product document exists
        if (productDoc.exists) {
          // Store the product details in categoriesDetails map
          categoriesDetails[productId] = productDoc.data();

          productDataList.add({
            "productId": productId,
            "collectionName": collectionName,
            "productData": productDoc.data(),
            'count': count,
            'is360degree': product['is360degree'] ?? false,
          });

          // Determine the correct price field based on conditions
          num priceField = categoriesDetails[productId]['MRP'] ?? 0;
          if (collectionName == 'WetWash' && product['is360degree'] == true) {
            totaldiscount += (categoriesDetails[productId]['Wash360MRP'] ?? 0 + priceField) *
                    count -
                (categoriesDetails[productId]['Wash360MRP'] ?? 0 + priceField) *
                    count *
                    (1 - (categoriesDetails[productId]['Discount'] ?? 0) / 100);

            // Add both 'Wash360price' and 'Price' if 'is360degree' is true
            totalPrice += (categoriesDetails[productId]['Wash360MRP'] ?? 0) *
                count *
                (1 - (categoriesDetails[productId]['Discount'] ?? 0) / 100);
            totalPrice += (priceField) *
                count *
                (1 - (categoriesDetails[productId]['Discount'] ?? 0) / 100);
          } else {
            totaldiscount += (priceField) * count -
                (priceField) *
                    count *
                    (1 - (categoriesDetails[productId]['Discount'] ?? 0) / 100);
            // Add only 'Price' if 'is360degree' is false or for other categories
            totalPrice += (priceField) *
                count *
                (1 - (categoriesDetails[productId]['Discount'] ?? 0) / 100);
          }
        }
      }
    }

    // Add the total price to the categoriesDetails map
    categoriesDetails["totalPrice"] = totalPrice;
    categoriesDetails['totalDiscount'] = totaldiscount;
    categoriesDetails["productDataList"] = productDataList;

    return categoriesDetails;
  }

  static Future<Map<String, dynamic>> fetchamcCategoriesDetails(
      List<DocumentSnapshot> generalproductWidgets) async {
    Map<String, dynamic> categoriesDetails = {};
    String docName = '5AMC';
    String subcollectionName = 'AMC';
    num totalPrice = 0;
    num totalDiscount = 0;
    List<Map<String, dynamic>> productDataList = [];

    Future<DocumentSnapshot> getProductDocument(
        String docName, String collectionName, String productId) async {
      return await FirebaseFirestore.instance
          .collection('Services')
          .doc('hWHRjpawA5D6OTbrjn3h')
          .collection('Categories')
          .doc(docName)
          .collection(collectionName)
          .doc(productId)
          .get();
    }

    for (var product in generalproductWidgets) {
      String productId = product.id;
      int count = product["count"] ?? 0;

      DocumentSnapshot productDoc =
          await getProductDocument(docName, subcollectionName, productId);

      if (productDoc.exists) {
        categoriesDetails[productId] = productDoc.data();

        productDataList.add({
          "productId": productId,
          "collectionName": subcollectionName,
          "productData": productDoc.data(),
          'count': count,
          'title': categoriesDetails[productId]['Content']['Title'],
          'UseTotalSpares': product['UseTotalSpares'],
        });

        String priceField = 'MRP';
        num productPrice =
            categoriesDetails[productId]['Content'][priceField] ?? 0;
        num sparesprice = categoriesDetails[productId]['Content']['TotalSparesMRP'] ?? 0;
        num discount =
            (categoriesDetails[productId]['Content']['Discount'] ?? 0) / 100;

        if (subcollectionName == 'AMC' && product['UseTotalSpares'] == true) {
          totalDiscount +=
              (sparesprice + productPrice) *
                  count - (sparesprice + productPrice) *
                  count *
                  (1 - discount);
          totalPrice +=
              (categoriesDetails[productId]['Content']['TotalSparesMRP'] ?? 0) *
                  count *
                  (1 - discount);
          totalPrice += productPrice * count * (1 - discount);
        } else {
          totalDiscount += (productPrice) * count -
              (productPrice) * count * (1 - (discount));
          ;
          totalPrice += productPrice * count * (1 - discount);
        }
      }
    }

    categoriesDetails["totalPrice"] = totalPrice;
    categoriesDetails['totalDiscount'] = totalDiscount;
    categoriesDetails["productDataList"] = productDataList;

    return categoriesDetails;
  }

  static Future<Map<String, dynamic>> getTotalDiscount(String uid) async {
    final Map<String, dynamic> allincart = {};
    // Fetch details for Products
    List<DocumentSnapshot> productWidgets = await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('ProductsCart')
        .get()
        .then((snapshot) => snapshot.docs);

    Map<String, dynamic> productDetails =
        await fetchCategoriesDetails(productWidgets);
    num productTotalDiscount = productDetails["totalDiscount"] ?? 0;
    num productTotalprice = productDetails["totalPrice"] ?? 0;
    List<Map<String, dynamic>> productDataList =
        productDetails["productDataList"];

// general product
    List<DocumentSnapshot> generalproductWidgets = await FirebaseFirestore
        .instance
        .collection('Users')
        .doc(uid)
        .collection('GeneralProductsCart')
        .get()
        .then((snapshot) => snapshot.docs);

    Map<String, dynamic> generalproductDetails =
        await fetchGeneralProductsDetails(generalproductWidgets);
    num generalproductTotalDiscount =
        generalproductDetails["totalDiscount"] ?? 0;
    num generalproductTotalprice = generalproductDetails["totalPrice"] ?? 0;
    List<Map<String, dynamic>> generalproductDataList =
        generalproductDetails["productDataList"];

    // Fetch details for Services
    List<DocumentSnapshot> serviceWidgets = await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('ServicesCart')
        .get()
        .then((snapshot) => snapshot.docs);

    Map<String, dynamic> serviceDetails =
        await fetchserviceCategoriesDetails(serviceWidgets);
    num serviceTotalDiscount = serviceDetails["totalDiscount"] ?? 0;
    num serviceTotalprice = serviceDetails["totalPrice"] ?? 0;
    List<Map<String, dynamic>> serviceDataList =
        serviceDetails["productDataList"];

    // Fetch details for Services
    List<DocumentSnapshot> AMCWidgets = await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('AMCCart')
        .get()
        .then((snapshot) => snapshot.docs);

    Map<String, dynamic> amcDetails =
        await fetchamcCategoriesDetails(AMCWidgets);
    num amcTotalDiscount = amcDetails["totalDiscount"] ?? 0;
    num amcTotalprice = amcDetails["totalPrice"] ?? 0;
    List<Map<String, dynamic>> amcDataList = amcDetails["productDataList"];

    // Sum up the total discounts from different streams
    num totalDiscount = productTotalDiscount +
        serviceTotalDiscount +
        amcTotalDiscount +
        generalproductTotalDiscount;
    num totalprice = productTotalprice +
        serviceTotalprice +
        amcTotalprice +
        generalproductTotalprice;

    allincart['totaldiscount'] = totalDiscount;
    allincart['totalprice'] = totalprice;
    allincart['allserviceproduct'] = {
      'productdatalist': productDataList,
      'servicedatalist': serviceDataList,
      'amcdatalist': amcDataList,
      'generalproductlist': generalproductDataList,
    };

    return allincart;
  }
}
