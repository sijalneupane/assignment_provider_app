import 'package:flutter/material.dart';

class HideKeyboard {
static void hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode()); // Unfocus any active focus node
}
}
