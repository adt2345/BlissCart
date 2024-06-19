import 'package:flutter/material.dart';

class TermsAndPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Policies'),
        backgroundColor: Colors.deepPurple[50],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to ChicPalette',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
              ),
              Divider(color: Colors.grey),
              SizedBox(height: 10),
              Text(
                'By using our website, you agree to our straightforward terms and conditions. We strive to provide accurate product info, but colors may vary. Orders are subject to availability and accepted payment methods. Shipping costs are your responsibility, and delivery times may vary. Check our Return and Exchange Policy for information on returns and exchanges. We respect your privacy; our Privacy Policy outlines how we handle your information. Our content is protected, so please don\'t reproduce it without permission. We\'re not liable for any damages arising from your use of our site. These terms are governed by the laws of your jurisdiction. For questions, reach out to us at Customer Care. Thanks for shopping with us!',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Return and Exchange Policy',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
              ),
              Divider(color: Colors.grey),
              SizedBox(height: 10),
              Text(
                'We want you to love your purchase from our store. If you\'re not satisfied, we accept returns within 30 days of delivery. Products must be unused and in their original packaging. Contact our customer service to initiate the return process. We don\'t cover return shipping costs. For exchanges, contact us to arrange a replacement.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Privacy Policy',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
              ),
              Divider(color: Colors.grey),
              SizedBox(height: 10),
              Text(
                'At our store, we take your privacy seriously. We only collect essential information needed to process your orders and provide a personalized shopping experience. Your data is securely stored and never shared with third parties. By using our site, you agree to our privacy practices. For more details on how we handle your information, please refer to our full Privacy Policy on our website. If you have any questions, feel free to reach out to us at Customer Care.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
void main() {
  runApp(MaterialApp(
    home: TermsAndPolicyPage(),
  ));
}
*/