import 'package:flutter/material.dart';
import 'package:provider_test1/utils/custom_icons.dart';
import 'package:provider_test1/widgets/custom_text.dart';
class SettingElevatedButton extends StatelessWidget {
  final String data;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? backgroundColor;

  const SettingElevatedButton({
    super.key,
    required this.data,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
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
            backgroundColor: backgroundColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Row(
            children: [
              CustomIcons(icon: icon),
              SizedBox(width: MediaQuery.of(context).size.width * 0.03),
              CustomText(data: data, color: Colors.white, fontSize: 16),
              Spacer(),
              CustomIcons(icon: Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
