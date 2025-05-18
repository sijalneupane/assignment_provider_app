
import 'package:flutter/material.dart';
import 'package:provider_test1/utils/custom_icons.dart';

class CustomNoBorderIconButton extends StatelessWidget {
 Function()? onPressed;
  Color? iconColor;
  IconData? icon;Color? iconButtonColor;
  CustomNoBorderIconButton(
      {super.key, required this.onPressed, this.iconColor,required this.icon,this.iconButtonColor});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed:onPressed,
        color: iconButtonColor,
        icon: CustomIcons (icon: icon,color: iconColor,));
  }
}