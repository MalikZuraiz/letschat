import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final TextEditingController? controller; // Add controller parameter

  const CustomTextField({
    super.key,
    required this.label,
    this.isPassword = false, // Default is not a password field
    this.controller, // Optional controller
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // Use the controller
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: const UnderlineInputBorder(), // Bottom border when unfocused
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), // Color when unfocused
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide:
              BorderSide(color: Colors.blue, width: 2), // Color when focused
        ),
      ),
    );
  }
}
