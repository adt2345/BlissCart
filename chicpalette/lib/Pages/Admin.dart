import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';

import 'dart:io';

import '../../models/dropdown.dart';


import 'authentication/firebase_auth_services.dart';



class AdminPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RentPageState();
  }
}

class RentPageState extends State<AdminPage> {

  TextEditingController namecontroller = TextEditingController();
  TextEditingController detailscontroller = TextEditingController();
  TextEditingController brandcontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();

  PlatformFile? pickedFile;

  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }



  Future<void> uploadFile() async {
    if (pickedFile == null) {
      print("No file picked");
      return;
    }

    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text("Saving data..."),
              ],
            ),
          );
        },
      );

      String imgPath = pickedFile!.path!;
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      Reference storageReference =
      FirebaseStorage.instance.ref().child('images/$fileName');

      await storageReference.putFile(File(imgPath));
      String fileUrl = await storageReference.getDownloadURL();

      // Save the file URL along with other details
      final name = namecontroller.text;
      final details = detailscontroller.text;
      final price = pricecontroller.text;
      final brand = brandcontroller.text;

      await saveDetails(
          name: name,
          details:details,
          imgPath: fileUrl,
          brand : brand,
          price:price
      );

      print("Details and image URL saved successfully");

      // Dismiss loading indicator
      Navigator.pop(context);

    } catch (error) {
      print('Error uploading file or saving details: $error');
      Navigator.pop(context);
    }
  }


  Future<void> saveDetails({
    required String name,
    required String details,
    required String imgPath,
    required String brand,
    required String price,

  }) async {
    try {
      CollectionReference vehiclesCollection =
      FirebaseFirestore.instance.collection('product-details');

      await vehiclesCollection.add({
        'name': name,
        'details': details,
        'img': imgPath,
        'product': brand,
        'price': price
      });
      print('Data added to Firestore successfully');
    } catch (error) {
      print('Error adding data to Firestore: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    String? SelectedBrand;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar:AppBar(
          title: Text(
            "ChicPalette Admin",
            style: TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontWeight: FontWeight.normal,
            ),
          ),
          backgroundColor: Colors.purple[50],
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 30, left: 20),
          child: Column(
            children: [
              Container(
                height: 50,
                width: 339,
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),

                ),
                child: Center(
                  child: TextField(
                    controller: namecontroller,
                    decoration: InputDecoration(
                      hintText: 'Enter Product Name',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 339,
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),

                ),
                child: Center(
                  child: TextField(
                    controller: detailscontroller,
                    decoration: InputDecoration(
                      hintText: 'Enter Product Description',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 339,
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(30),

                ),
                padding: EdgeInsets.only(left: 15, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(pickedFile != null
                          ? 'File Selected: ${pickedFile!.name}'
                          : 'Upload Images'),
                    ),
                    GestureDetector(
                      onTap: () {
                        selectFile();
                      },
                      child: Icon(Icons.file_upload_outlined, size: 25,),
                    ),
                  ],
                ),
              ),// Upload
              const SizedBox(
                height: 20,
              ),
              DropDown.buildDropdownContainer(
                context,
                "Select Makeup Products ",
                ["Foundation", "Mascara", "Lipstick", "Concealer","Eyeshadow","Blush"],
                SelectedBrand ,
                    (String? newValue) {
                  setState(() {
                    SelectedBrand = newValue;
                    brandcontroller.text = newValue ?? "";
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 339,
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(30),

                ),
                child: Center(
                  child: TextField(
                    controller: pricecontroller,
                    decoration: InputDecoration(
                      hintText: 'Enter Product Price',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                ),
              ),//Price
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      uploadFile();
                    },
                    child: Container(
                      height: 45,
                      width: 146,
                      decoration: BoxDecoration(
                        color: Colors.purple[50],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Tapped on logout icon');
                      signOutUser(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.logout, size: 30, color: Colors.purple[100]), // Set the icon color to red
                          SizedBox(width: 10),
                          Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}