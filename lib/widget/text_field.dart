import 'package:flutter/material.dart';
import 'package:hotel_reservation_app/theme/color.dart';

class NormalTextField extends StatelessWidget {
  const NormalTextField({super.key, required this.controller, required this.text, this.icon});
  final TextEditingController controller;
  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          suffixIconConstraints: BoxConstraints(minWidth: 80),
          suffixIcon: icon == null ? SizedBox.shrink() : Icon(icon),
          hintText: text,
          labelStyle: TextStyle(color: AppColor().teal, fontSize: 20),
          fillColor: AppColor().text,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor().teal, width: 3),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor().teal, width: 3),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
