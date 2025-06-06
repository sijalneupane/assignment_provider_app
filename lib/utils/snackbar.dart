import 'package:flutter/material.dart';
import 'package:provider_test1/widgets/custom_icon_button.dart';
import 'package:provider_test1/widgets/custom_icons.dart';
import 'package:provider_test1/widgets/custom_no_border_icon_button.dart';

displaySnackBar(BuildContext context, String message) {
  var snackBar = SnackBar(
    content: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: 48.0,
          ), // leave space for close button
          child: Text(message, softWrap: true),
        ),
        Positioned(
          right: 0,
          top: 0,
          child:GestureDetector(
            child: CustomIcons(icon: Icons.close,color: Colors.white,),
            onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          )
          ),
        
      ],
    ),
    duration: Duration(seconds: 5),
    behavior: SnackBarBehavior.floating,
    clipBehavior: Clip.antiAlias,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
