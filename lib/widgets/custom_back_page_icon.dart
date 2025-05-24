
import 'package:flutter/material.dart';
import 'package:provider_test1/widgets/custom_border_icon_button.dart';
import 'package:provider_test1/widgets/custom_no_border_icon_button.dart';

class CustomBackPageIcon extends StatelessWidget {
   IconData? icon;
  CustomBackPageIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child:
      CustomNoBorderIconButton(onPressed:  () {
          Navigator.pop(context);
          }, icon: Icons.arrow_back,
) 
      // Container(
      //   height: MediaQuery.of(context).size.height*0.05,
      //   decoration: BoxDecoration(
      //     shape: BoxShape.circle,
      //     color: Colors.white,
      //     border: Border.all(color: const Color.fromARGB(117, 216, 216, 216), width: 1), // Black border
      //   ),
      //   child: IconButton(
      //     iconSize: 18,
      //     onPressed: () {
      //     Navigator.pop(context);
      //     },
      //     icon: Icon(Icons.arrow_back), // Icon color inside
      //   ),
      // ),
    );
  }
}
