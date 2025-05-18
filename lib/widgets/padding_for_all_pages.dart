import 'package:flutter/material.dart';

class PaddingForAllPages extends StatelessWidget {
  Widget? child;
  double? topPadding;
  double? rightPadding;
  double? bottomPadding;
  double? leftPadding;
  PaddingForAllPages(
      {super.key,
      this.child,
      this.topPadding,
      this.rightPadding,
      this.bottomPadding,
      this.leftPadding,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: topPadding ?? 4,
        right: rightPadding ?? 12.0,
        bottom: bottomPadding ?? 14,
        left: leftPadding ?? 12.0,
      ),
      child: child,
    );
  }
}
