
import 'package:flutter/material.dart';
import 'package:provider_test1/widgets/custom_text.dart';

class CustomOnTapLink extends StatelessWidget {
  String data;
  void Function()? onTap;
   CustomOnTapLink({super.key,required this.data,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:CustomText(data:data) ,
    );
  }
}