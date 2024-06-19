import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chicpalette/Pages/CataloguePage.dart';
import 'package:chicpalette/Pages/CartPage.dart';
import 'package:chicpalette/Pages/Profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Index for the selected tab

  @override
  Widget build(BuildContext context) {
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
      body: Container(
        color: Colors.purple[50],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                margin: EdgeInsets.all(16.0),
                padding: EdgeInsets.all(16.0),
                child: CarouselSlider(
                  items: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('lib/images/featured3rd.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Center(
                        child: Text('Slide 1', style: TextStyle(color: Colors
                            .white)),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('lib/images/featured4th.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('lib/images/featured2nd.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Center(
                        child: Text('Slide 3', style: TextStyle(color: Colors
                            .white)),
                      ),
                    ),
                  ],
                  options: CarouselOptions(
                    height: 150.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                ),
              ),
              Container(
                color: Colors.purple[50],
                child: SizedBox(
                  height: 19.0,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '    Suggested for you',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                color: Colors.purple[50],
                height: 350.0,
                margin: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.0),
                      ProductCard(
                          name: 'Soft Pinch Liquid Blush - Believe | Rare Beauty',
                          imagePath: 'lib/images/blush.png',
                      description: 'A weightless, long-lasting liquid blush that blends and builds beautifully for a soft, healthy flush. Available in both matte and dewy finishes.'),
                      ProductCard(
                          name: 'Pro Filt’r Soft Matte Longwear Liquid Foundation | Fenty Beauty',
                          imagePath: 'lib/images/fentyfoundation.png',
                        description: 'Flexes with your skin in every environment to absorb oil instantly, reduce shine and leave a matte finish. Non-drying, and sweat- and humidity- resistant.',),
                      ProductCard(
                          name: 'Non-Sticky Lip Mousse Velvet Lip Color | L.A. Girls',
                          imagePath: 'lib/images/lagirllipstickII.png',
                        description: 'The velvety formula goes on buttery soft, giving a seamless finish with maximum color payoff that wears down evenly throughout the day.',),
                      ProductCard(name: 'Volume Mascara | KYLASH',
                          imagePath: 'lib/images/mascara.png',
                        description: 'Featuring a clean and vegan formula that doesn’t compromise on performance, this mascara provides volume, length and holds curl.',),
                    ],
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
            // Navigate to HomePage (itself)
              break;
            case 1:
            // Navigate to CataloguePage
              _navigateToPage(MakeupCategoryPage());
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
}


class ProductCard extends StatelessWidget {
  final String name;
  final String imagePath;

  final String description;

  ProductCard({required this.name, required this.imagePath, this.description='',});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(8.0),
        title: Text(
          name,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        leading: Container(
          width: 50.0,
          height: 50.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              imagePath,
              width: 50.0,
              height: 50.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
        onTap: () {
          _showProductAlertDialog(context, name, description);
        },
      ),
    );
  }
}

void _showProductAlertDialog (BuildContext context, String name, String description){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(name),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}




