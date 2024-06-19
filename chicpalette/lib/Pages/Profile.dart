import 'package:chicpalette/Pages/CartPage.dart';
import 'package:chicpalette/Pages/CataloguePage.dart';
import 'package:chicpalette/Pages/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'profileSetting.dart';
import 'termsncondition.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 2; // Set the initial index to the profile page

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'ChicPalette',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: Colors.purple[50],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Icon(Icons.account_circle, size: 40), // Add user icon here
                    SizedBox(height: 8),
                    Text(
                      user?.email ?? '',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            buildListTile(
              'Profile Settings',
              Icons.manage_accounts_outlined,
                  () => _navigateToPage(ProfileSettingScreen()),
            ),
            buildDivider(Colors.grey),

            buildListTile(
              'Customer Care',
              Icons.contact_support_outlined,
                  () {
                // Add functionality for Customer Care
                // For example, show a dialog with contact information
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Customer Care'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Contact us at:'),
                          buildDivider(Colors.grey),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.call_outlined),
                              SizedBox(width: 8),
                              Text('Phone: 9808946072,'),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              SizedBox(width: 8),
                              Text('                : 9840031630,'),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              SizedBox(width: 8),
                              Text('                : 9847238425.'),
                            ],
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            buildDivider(Colors.grey),
            buildListTile(
              'Legal Terms and Policies',
              Icons.info_outlined,
                  () {
                _navigateToPage(TermsAndPolicyPage());
              },
            ),
            buildDivider(Colors.grey),
            SizedBox(height: 193),

            Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  // Add functionality for log out
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text('Log Out'),
              ),
            )

          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // Handle navigation to different tabs here
          switch (index) {
            case 0:
            // Navigate to SavedPage
              _navigateToPage(HomePage());
              break;
            case 1:
            // Navigate to OrderHistoryPage
              _navigateToPage(MakeupCategoryPage());
              break;
            case 2:
            // Stay on ProfilePage
              break;
            case 3:
            // Navigate to PrivacyPolicyPage
              _navigateToPage(CartPage());
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_rounded),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_rounded),
            label: 'Cart',
          ),
        ],
        selectedItemColor: Colors.deepPurple[300],
        unselectedItemColor: Colors.deepPurple[100],
      ),
    );
  }

  ListTile buildListTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      title: Row(
        children: [
          Icon(icon),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  Widget buildDivider(Color color) {
    return Divider(
      color: color,
    );
  }

  void _navigateToPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}



