import 'package:flutter/material.dart';
import 'package:qrone/utils/extensions/buildcontextExtension.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {super.key,
      required this.validator,
      required this.ctrl,
      required this.hint,
      this.keyboard = TextInputType.name,
      required this.icon});
  final TextInputType keyboard;
  final TextEditingController ctrl;
  final String hint;
  final String? Function(String?)? validator;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width / 1.3,
      child: TextFormField(
        controller: ctrl,
        keyboardType: keyboard,
        validator: validator,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.cyan),
            borderRadius: BorderRadius.circular(5.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.cyan),
            borderRadius: BorderRadius.circular(5.5),
          ),
          prefixIcon: Icon(icon, color: Colors.blue),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.blue),
          filled: true,
          fillColor: Colors.blue[50],
        ),
      ),
    );
  }
}
