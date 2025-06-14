import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:provider/provider.dart';
import 'package:provider_test1/features/notices/model/add_notices_model.dart';
import 'package:provider_test1/features/notices/provider/notices_provider.dart';
import 'package:provider_test1/utils/color_utils.dart';
import 'package:provider_test1/utils/network_status.dart';
import 'package:provider_test1/utils/route_const.dart';
import 'package:provider_test1/utils/route_generator.dart';
import 'package:provider_test1/utils/snackbar.dart';
import 'package:provider_test1/utils/spin_kit.dart';
import 'package:provider_test1/utils/string_const.dart';
import 'package:provider_test1/widgets/custom_app_bar.dart';
import 'package:provider_test1/widgets/custom_elevatedbutton.dart';
import 'package:provider_test1/widgets/custom_image_picker.dart';
import 'package:provider_test1/widgets/custom_text.dart';
import 'package:provider_test1/widgets/custom_textformfield.dart';
import 'package:provider_test1/widgets/custom_dropdown.dart';
import 'package:provider_test1/widgets/custom_date_time_input.dart'; // Make sure this path matches your file structure

class AddNoticeForm extends StatelessWidget {
  AddNoticeForm({super.key});

  // void _submitForm() {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(addNoticeStr),
      //   backgroundColor: Colors.teal,
      // ),
      body: Consumer<NoticesProvider>(
        builder:
            (context, noticesProvider, child) => Form(
              key: noticesProvider.loginFormKey,
              // key: _formKey,
              child: RefreshIndicator.adaptive(
                onRefresh: () {
                  return Future.sync(() async {
                    // You can trigger a provider refresh or reload logic here if needed.
                    // For now, just rebuild the widget.
                    noticesProvider.clearFormFields();
                  });
                },
                child: Stack(
                  children: [
                    _addnotceUi(noticesProvider, context),
                    noticesProvider.getAddNoticeStatus == NetworkStatus.loading
                        ? Loader.backdropFilter(context)
                        : SizedBox(),
                  ],
                ),
              ),
            ),
      ),
    );
  }

  Widget _addnotceUi(NoticesProvider noticesProvider, BuildContext context) {
    return ListView(
      children: [
        CustomAppBar(hasBackButton: true,middleChild: CustomText(data: addNoticeStr,isPageTitle: true,),),
        SizedBox(height: 10),
        CustomTextformfield(
          validator: (value) {
            if (value!.isEmpty) {
              return "please enter the title";
            }
            return null;
          },
          controller: noticesProvider.titleController,
          labelText: titleStr,
        ),
        // CustomTextformfield(
        //   labelText: contentStr,
        //   validator: (value) {
        //     if (value!.isEmpty) {
        //       return "please enter the content";
        //     }
        //     return null;
        //   },

        //   controller: noticesProvider.contentController,
        // ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        //   child: CustomDateTimeInput(
        //     labelText: noticeDateStr,
        //     controller: noticesProvider.dateController,
        //     pickerType: "date",
        //     validator: (value) {
        //       if (value == null || value.isEmpty) {
        //         return "Notice Date cannot be empty";
        //       }
        //       return null;
        //     },
        //   ),
        // ),
        CustomDropdown(
          labelText: categoryStr,
          dropDownItemList: noticesProvider.categoryOptions,
          value: noticesProvider.selectedCategory,
          onChanged: (p0) {
            noticesProvider.selectedCategory = p0;
          },
        ),
        CustomDropdown(
          labelText: priorityStr,
          dropDownItemList: noticesProvider.priorityOptions,
          value: noticesProvider.selectedPriority,
          onChanged: (p0) {
            noticesProvider.selectedPriority = p0;
          },
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomImagePicker(
            afterPickingImage: noticesProvider.afterPickingImage,
            validator: (imageFile) {
              if (imageFile == null) {
                return "Please select an image";
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: MultiSelectContainer(
            // splashColor: Colors.red,
            prefix: MultiSelectPrefix(
              selectedPrefix: Icon(Icons.check_circle, color: Colors.green),
              enabledPrefix: Icon(
                Icons.radio_button_unchecked,
                color: Colors.grey,
              ),
            ),
            items: [
              MultiSelectCard(
                value: noticesProvider.audienceOptions[0],
                label: noticesProvider.audienceOptions[0],
              ),
              MultiSelectCard(
                value: noticesProvider.audienceOptions[1],
                label: noticesProvider.audienceOptions[1],
              ),
              MultiSelectCard(
                value: noticesProvider.audienceOptions[2],
                label: noticesProvider.audienceOptions[2],
              ),
              MultiSelectCard(
                value: noticesProvider.audienceOptions[3],
                label: noticesProvider.audienceOptions[3],
              ),
            ],
            onChange: (allSelectedItems, selectedItem) {
              if (noticesProvider.checkIfAudienceAreAll(allSelectedItems)) {
                return;
              }
              noticesProvider.selectedAudience = allSelectedItems;
            },
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //        CustomText(data: targetAudienceStr,fontWeight: FontWeight.bold),
        //       ...noticesProvider.audienceOptions.map((audience) {
        //         return CheckboxListTile(
        //           title: Text(audience),
        //           value: noticesProvider.selectedAudience.contains(audience),
        //           onChanged: (val) {
        //             // setState(() {
        //             //   if (val == true) {
        //             //    noticesProvider. selectedAudience.add(audience);
        //             //   } else {
        //             //     noticesProvider.selectedAudience.remove(audience);
        //             //   }
        //             // });
        //           },
        //         );
        //       }).toList(),
        //     ],
        //   ),
        // ),
        CustomElevatedbutton(
          child:
               Text(addNoticeStr),
          onPressed: () async {
            if (noticesProvider.loginFormKey.currentState!.validate()) {
              await noticesProvider.addNotice();
              if (noticesProvider.getAddNoticeStatus == NetworkStatus.success) {
                displaySnackBar(context, addNoticeSuccessStr);

                RouteGenerator.navigateToPageReplacement(
                  context,
                  Routes.getNoticeRoute,
                );
              } else {
                displaySnackBar(
                  context,
                  noticesProvider.errorMsg ?? addNoticeFailedStr,
                );
              }
            }
          },
        ),
      ],
    );
  }
}
