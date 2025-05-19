
import 'package:flutter/material.dart';
import 'package:provider_test1/widgets/custom_text.dart';

class CustomInkwell extends StatelessWidget {
  String data;
  void Function()? onTap;
   CustomInkwell({super.key,required this.data,this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child:CustomText(data:data) ,
      onTap: onTap,
    );
  }
}