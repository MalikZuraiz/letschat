import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType keyboardType; // New keyboardType parameter

  const CustomTextField({
    super.key,
    required this.label,
    this.isPassword = false,
    this.suffixIcon,
    this.controller,
    this.keyboardType = TextInputType.text, // Default keyboard type is text
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType, // Set the keyboard type here
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
        border: const UnderlineInputBorder(),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
