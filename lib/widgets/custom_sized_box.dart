import 'package:flutter/material.dart';

class CustomSizedBox extends StatelessWidget {
  double? height;
  double? width;
  CustomSizedBox({super.key,this.height,this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:height!=null? MediaQuery.of(context).size.height * height! :0.0,
      width:width!=null? MediaQuery.of(context).size.width * width! :0.0,
    );
  }
}