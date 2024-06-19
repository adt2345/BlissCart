/*
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Function()? onCartPressed;

  CustomAppBar({Key? key, required this.title, this.onCartPressed})
      : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);*/
/**//*

}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: TextStyle(color: Colors.red[100], fontSize: 30, fontWeight: FontWeight.w600),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Image.asset('lib/images/logo.png'),
          height: 32,
          width: 32,
        ),
      ),
    );
  }
}*/
