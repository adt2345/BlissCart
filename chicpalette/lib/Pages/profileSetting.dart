import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chicpalette/Pages/Profile.dart';

class ProfileSettingScreen extends StatefulWidget {
  @override
  _ProfileSettingScreenState createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User _currentUser;
  late TextEditingController _fullNameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser!;
    _fullNameController = TextEditingController(text: _currentUser.displayName ?? '');
    _addressController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _emailController = TextEditingController(text: _currentUser.email ?? '');
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    try {
      await _currentUser.updateDisplayName(_fullNameController.text);
      await _currentUser.updateEmail(_emailController.text);

      DocumentSnapshot userSnapshot = await _firestore.collection('users').doc(_currentUser.uid).get();

      if (userSnapshot.exists) {
        await _firestore.collection('users').doc(_currentUser.uid).update({
          'address': _addressController.text,
          'number': _phoneNumberController.text,
        });

        if (_passwordController.text.isNotEmpty) {
          await _currentUser.updatePassword(_passwordController.text);
        }

        await _currentUser.reload();
        _currentUser = _auth.currentUser!;
        print('Profile updated successfully');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );

      await _showUpdateConfirmationDialog();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    } catch (e) {
      print('Error updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
      );
    }
  }

  Future<void> _showUpdateConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Confirmed'),
          content: Text('Your profile has been updated!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Settings'),
        backgroundColor: Colors.deepPurple[50],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildTextField('Full Name', _fullNameController),
            SizedBox(height: 8),
            _buildTextField('Email', _emailController, isEnabled: false),
            SizedBox(height: 8),
            _buildTextField('Phone Number', _phoneNumberController),
            SizedBox(height: 8),
            _buildTextField('Address', _addressController),
            SizedBox(height: 16),
            Text(
              'Security Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildTextField('Change Password', _passwordController, isPassword: true),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await _saveChanges();
              },
              child: Text(
                'Save Changes',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.deepPurple[200],
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isEnabled = true, bool isPassword = false}) {
    return TextField(
      controller: controller,
      enabled: isEnabled,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}
