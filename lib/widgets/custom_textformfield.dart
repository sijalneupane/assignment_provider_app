import 'package:flutter/material.dart';

class CustomTextformfield extends StatelessWidget {
  String? labelText;
  Widget? suffixIcon;
  bool? obscureText;
  TextInputType? keyboardType;
  TextEditingController? controller;
  void Function(String)? onChanged;
  String? initialValue;
  String? Function(String?)? validator;
  CustomTextformfield({
    super.key,
    this.labelText,
    this.suffixIcon,
    this.obscureText,
    this.keyboardType,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 80),
      child: Padding(
        // padding: const EdgeInsets.all(0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),

        child: TextFormField(
          initialValue: initialValue,
          controller: controller,
          keyboardType: keyboardType ?? TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          onChanged: onChanged,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: const Color.fromARGB(255, 7, 5, 181),
              ),
            ),
            labelText: labelText,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          ),
        ),
      ),
    );
  }
}
