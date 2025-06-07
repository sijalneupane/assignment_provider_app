import 'package:flutter/material.dart';
import 'package:provider_test1/utils/dialog_box.dart';
import 'package:provider_test1/utils/route_const.dart';
import 'package:provider_test1/utils/route_generator.dart';
import 'package:provider_test1/widgets/custom_border_icon_button.dart';
import 'package:provider_test1/widgets/custom_icon_button.dart';

class EditDeleteButton {
   Widget editButton({
    required BuildContext context,
    dynamic arguments,
    required String route,
  }) {
    return CustomIconButton(
      onPressed: () {
        RouteGenerator.navigateToPage(context, route, arguments: arguments);
      },
      edit: true,
      color: Colors.blue,
    );
  }

  Widget deleteButton({
    required BuildContext context,
    dynamic arguments,
    required String dialogTitle,required String dialogMessage,required void Function() onOkPressed
  }) {
    return CustomIconButton(
      onPressed: () {
                                DialogBox.showConfirmBox(
                                  context: context,
                                  title: dialogTitle,
                                  message: dialogMessage,
                                  onOkPressed:onOkPressed
                                );
                              },
                              edit: false,
                              color: Colors.red,
    );
  }
}
