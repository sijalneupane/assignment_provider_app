import 'package:flutter/material.dart';
import 'package:provider_test1/widgets/custom_icons.dart';
 
import 'package:provider_test1/widgets/custom_text.dart';
class SettingElevatedButton extends StatelessWidget {
  final String data;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? textColor;
  final Color? backgroundColor;
   Color? borderColor;
   Color? foregroundColor;

   SettingElevatedButton({
    super.key,
    this.textColor,
    required this.data,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.borderColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width * 0.03,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.07,
        child: ElevatedButton(
          onPressed: onPressed,
          
          style: ElevatedButton.styleFrom(
            side: BorderSide(color:borderColor?? Colors.blue),
            backgroundColor: backgroundColor??Colors.white,
            foregroundColor: foregroundColor??Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Row(
            children: [
              CustomIcons(icon: icon,
                color:foregroundColor?? Theme.of(context).primaryColor,
              
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.03),
              Text(data, style:TextStyle(fontSize: 16) ),
              Spacer(),
              CustomIcons(icon: Icons.arrow_forward_ios,
                color:foregroundColor?? Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
