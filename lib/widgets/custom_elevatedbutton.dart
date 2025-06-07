import 'package:flutter/material.dart';
import 'package:provider_test1/utils/color_utils.dart';

class CustomElevatedbutton extends StatelessWidget {
  Function()? onPressed;
  Widget? child;
  // double? height;
  CustomElevatedbutton({super.key,this.onPressed,this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height:50,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(onPressed:onPressed, child:child,style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: fourthColor,
          textStyle: TextStyle(fontSize: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
        ),)),
    );
  }
}