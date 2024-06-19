import 'package:chicpalette/Pages/LoginPage.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Displaypage extends StatefulWidget {
  const Displaypage({super.key});

  @override
  State<Displaypage> createState() => _DisplaypageState();
}

class _DisplaypageState extends State<Displaypage> {
  @override
  void initState() {
    super.initState();
    // Add code after super
    navigateToNextPage();
  }

  Future<void> navigateToNextPage() async {
    await Future.delayed(Duration(seconds: 4)); // Change the duration as needed

    // Navigate to the next page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()), // Replace 'YourNextPage' with the actual page you want to navigate to
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.purple[50],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/images/1.1.png',
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}


class YourNextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Text('Welcome to the Next Page!'),
      ),
    );
  }
}
