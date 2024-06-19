import 'package:chicpalette/Pages/Admin.dart';
import 'package:chicpalette/Pages/CartPage.dart';
import 'package:chicpalette/Pages/CataloguePage.dart';
import 'package:chicpalette/Pages/Displaypage.dart';
import 'package:chicpalette/Pages/HomePage.dart';
import 'package:chicpalette/Pages/LoginPage.dart';
import 'package:chicpalette/Pages/Mascara.dart';
import 'package:chicpalette/Pages/Profile.dart';
import 'package:chicpalette/Pages/SignUpPage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chicpalette/models/cart_provider.dart';
import 'package:chicpalette/models/Cart.dart';
import 'package:chicpalette/Pages/CartPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart'; // Import Firebase Core

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Configure GoogleSignIn for web
  GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: '657647465444-ijd8qmagltto17bjhb350ta3ibjinmu1.apps.googleusercontent.com', // Replace with your Google Sign-In client ID
    scopes: ['email'],
  );
  googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
    // Handle user sign-in or sign-out
    print('onCurrentUserChanged: $account');
  });

  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChicPalette',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Displaypage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}