import 'package:flutter/material.dart';

class CustomImageAssets extends StatelessWidget {
  String name;
  double? height;
  double? width;
  BoxFit? fit;
   CustomImageAssets({super.key,required this.name,this.height,this.width,this.fit});

  @override
  Widget build(BuildContext context) {
    return Image.asset(name,height: height,width: width,fit:fit ,);
  }
}