
import 'package:flutter/material.dart';
import 'package:provider_test1/utils/color_utils.dart';

class CustomIcons extends StatelessWidget {
  IconData? icon;
  double? size;
  Color? color;
  CustomIcons({super.key,required this.icon,this.size,this.color});

  @override
  Widget build(BuildContext context) {
    return Icon(icon,size: size,color: color??primaryColor,);
  }
}