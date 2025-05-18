import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  Function()? onPressed;
  bool? edit;
  Color? color;
  CustomIconButton(
      {super.key, required this.onPressed, required this.edit, this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed:onPressed,
        icon: Icon(
          (edit!) ? Icons.edit : Icons.delete,
          color: color,
        ));
  }
}
