import 'package:flutter/material.dart';

displaySnackBar(BuildContext context,String message){
  var snackBar = SnackBar(
  content: Text(message),
  duration: Duration(seconds: 5),
  behavior: SnackBarBehavior.floating,
  clipBehavior: Clip.antiAlias,
);
ScaffoldMessenger.of(context).showSnackBar(snackBar);
}