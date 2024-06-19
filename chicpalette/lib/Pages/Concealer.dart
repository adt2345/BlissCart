import 'package:chicpalette/Pages/CataloguePage.dart';
import 'package:chicpalette/Pages/Profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../../models/Cart.dart';
import '../../models/cart_provider.dart';
import 'CartPage.dart';
import 'HomePage.dart';

class Concealer extends StatefulWidget {
  @override
  _ConcealerState createState() => _ConcealerState();
}

class _ConcealerState extends State<Concealer> {
  List<Map<String, dynamic>> concealerProduct = [];
  int _currentIndex = 1;

  // Fetch data from Firestore
  Future<void> fetchDataFromFirestore() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('product-details') // Replace with your actual collection name
          .where('product', isEqualTo: 'Concealer')
          .get();

      setState(() {
        concealerProduct = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      });

      // Debugging: Print the retrieved data
      print('Fetched Data: $concealerProduct');
    } catch (e) {
      print('Error fetching data from Firestore: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Concealer"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back when the back button is pressed
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MakeupCategoryPage()), // Replace MakeupCategoryPage with your actual page
            );
          },
        ),
        backgroundColor: Colors.purple[50],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.73,
                    ),
                    itemCount: concealerProduct.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  color: Color(concealerProduct[index]['color'] ?? 0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Image.network(
                                    concealerProduct[index]['img'],
                                    height: 160,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              concealerProduct[index]['name'] ?? '',
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'Rs.' + (concealerProduct[index]['price'] ?? 0).toString(),
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                var cartProvider = context.read<CartProvider>();
                                cartProvider.addToCart(CartItem(
                                  name: concealerProduct[index]['name'],
                                  price: double.parse(concealerProduct[index]['price'].toString()),
                                  imagePath: concealerProduct[index]['img'],
                                ));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Added to Cart: ${concealerProduct[index]['name']}'),
                                  ),
                                );
                              },
                              child: Text('Add to Cart'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          switch (index) {
            case 0:
            // Navigate to HomePage
              _navigateToPage(HomePage());
              break;
            case 1:
            // Navigate to CataloguePage (itself)

              break;
            case 2:
            // Navigate to ProfilePage
              _navigateToPage(ProfilePage());
              break;
            case 3:
            // Navigate to CartPage
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

  void _navigateToPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }


  Widget buildProductCard(Map<String, dynamic> concealerProduct) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Color(concealerProduct['color']),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Color(concealerProduct['color']).withOpacity(0.5),
                      ),
                    ),
                    Image.asset(
                      concealerProduct['image'],
                      height: 160,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Text(
            concealerProduct['name'],
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          Text(
            r'Rs.' + concealerProduct['price'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          // Add to Cart Button
          ElevatedButton(
            onPressed: () {
              // Get the CartProvider instance
              var cartProvider = context.read<CartProvider>();

              // Add the selected item to the cart
              cartProvider.addToCart(CartItem(
                name: concealerProduct['name'],
                price: double.parse(concealerProduct['price']),
                imagePath: concealerProduct['image'],
              ),);

              // Show a snackbar or navigate to the cart page
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added to Cart: ${concealerProduct['name']}'),
                ),
              );
            },
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}