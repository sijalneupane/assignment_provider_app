import 'package:flutter/material.dart';
import 'package:provider_test1/widgets/custom_text.dart';

class CustomDropdown extends StatelessWidget {
  List<String> dropDownItemList;
  Function(String?)? onChanged;
  String? labelText;
  TextEditingController? controller;
  String? value;
  EdgeInsetsGeometry? outerPadding;
  CustomDropdown({
    super.key,
    required this.dropDownItemList,
    this.onChanged,
    this.labelText,
    this.controller,
    this.value,
  });
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 80),

      child: Padding(
        padding: outerPadding ??const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),

        child: DropdownButtonFormField(
          value: value,
          dropdownColor: const Color.fromARGB(255, 62, 135, 153),
          decoration: InputDecoration(
            labelText: labelText,
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          ),
          items:
              dropDownItemList
                  .map(
                    (e) =>
                        DropdownMenuItem(value: e, child: CustomText(data: e)),
                  )
                  .toList(),
          onChanged: onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null) {
              return "$labelText cannot be empty";
            }
            return null;
          },
        ),
      ),
    );
  }
}
