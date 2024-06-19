import 'package:flutter/material.dart';



class DropDown {
  static Widget buildDropdownContainer(
      BuildContext context,
      String label,
      List<String> options,
      String? selectedValue,
      ValueChanged<String?> onChanged,
      ) {
    return Container(
      width: 339,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        //boxShadow: [CustomBoxShadow()],
      ),
      child: DropdownButtonFormField(
        value: selectedValue,
        items: options.map((option) {
          return DropdownMenuItem(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15), // Adjust padding
          hintText: selectedValue != null ? selectedValue : label,
          border: InputBorder.none,
        ),
      ),
    );
  }
}