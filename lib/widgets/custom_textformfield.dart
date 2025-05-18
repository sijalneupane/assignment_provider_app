import 'package:flutter/material.dart';

class CustomTextformfield extends StatelessWidget {
  String? labelText;
  Widget? suffixIcon;
  bool? obscureText;
  TextInputType? keyboardType;
  TextEditingController? controller;
  CustomTextformfield({super.key,this.labelText,this.suffixIcon,this.obscureText,this.keyboardType,this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType:keyboardType ??TextInputType.text ,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator:(value) {
          if(value!.isEmpty){
            return "$labelText cannot be empty";
          }
          return null;
        },
        obscureText:obscureText??false ,
        decoration: InputDecoration(
          labelText:labelText ,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5)
          )
        ),
      ),
    );
  }
}