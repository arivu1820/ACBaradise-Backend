import 'package:acbaradise/Widgets/SingleWidgets/AppbarWithCart.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  final String uid;
  const PrivacyPolicyScreen({Key? key,required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWithCart(PageName: 'T&C Privacy Policy', iscart: false, uid: uid),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'This Privacy Policy explains how [Your Company Name] collects, uses, and discloses personal information when you use our mobile application ("App") and the services provided through it.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Information We Collect',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'When you use our App, we may collect the following information:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text('• Name'),
            Text('• Email address'),
            Text('• Profile information'),
            SizedBox(height: 8.0),
            Text(
              'This information is collected during the authentication process using your email account. Additionally, when you use our services and purchase products through the App, we may collect information related to your purchases, such as items added to the cart, payment details, and order history.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Use of Information',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'We use the information collected for the following purposes:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text('• Providing and personalizing our services to you.'),
            Text('• Processing transactions and delivering products you purchase through the App.'),
            Text('• Verifying and fulfilling orders.'),
            Text('• Communicating with you about your orders and providing customer support.'),
            Text('• Improving our products and services.'),
            Text('• Complying with legal obligations.'),
            SizedBox(height: 16.0),
            Text(
              'Third-Party Payment Gateway',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'For payment processing, we use a third-party payment gateway to ensure the security of your transactions. Your payment details will be securely handled by the payment gateway provider during the checkout process.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Order Processing and Refunds',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Once your order is placed, the information you provided will be forwarded to our administrators for verification and order fulfillment. Payment details will be stored in an additional local server. If you wish to cancel your order and request a refund, you can contact our support center. Refunds will be processed within 7 working days, and the amount will be refunded to your original payment method.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Data Security',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'We take reasonable measures to protect your personal information from unauthorized access, use, or disclosure. However, please note that no method of transmission over the internet or electronic storage is 100% secure.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Changes to This Privacy Policy',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'We may update our Privacy Policy from time to time. Any changes will be posted on this page with a revised effective date.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'If you have any questions about our Privacy Policy or the practices of this App, please contact us at +91 638221939.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
