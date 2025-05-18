
import 'package:flutter/material.dart';
import 'package:provider_test1/widgets/custom_text.dart';

class CustomInkwell extends StatelessWidget {
  String data;
  Widget Function(BuildContext) builder;
   CustomInkwell({super.key,required this.data,required this.builder});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child:CustomText(data:data) ,
      onTap: () {
        Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:builder ),(Route<dynamic> route) => false);
      },
    );
  }
}