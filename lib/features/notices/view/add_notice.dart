import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test1/features/notices/model/add_notices_model.dart';
import 'package:provider_test1/features/notices/provider/notices_provider.dart';
import 'package:provider_test1/utils/network_status.dart';
import 'package:provider_test1/utils/route_const.dart';
import 'package:provider_test1/utils/route_generator.dart';
import 'package:provider_test1/utils/snackbar.dart';
import 'package:provider_test1/utils/spin_kit.dart';
import 'package:provider_test1/utils/string_const.dart';
import 'package:provider_test1/widgets/custom_elevatedbutton.dart';
import 'package:provider_test1/widgets/custom_text.dart';
import 'package:provider_test1/widgets/custom_textformfield.dart';
import 'package:provider_test1/widgets/custom_dropdown.dart';
import 'package:provider_test1/widgets/custom_date_time_input.dart'; // Make sure this path matches your file structure

class AddNoticeForm extends StatefulWidget {
  
   AddNoticeForm({super.key});

  @override
  State<AddNoticeForm> createState() => _AddNoticeFormState();
}

class _AddNoticeFormState extends State<AddNoticeForm> {
  final _formKey = GlobalKey<FormState>();

  // void _submitForm() {
  //   if (_formKey.currentState!.validate()) {
  //     final newNotice = AddNoticesModel(
  //       title: titleController.text,
  //       content: contentController.text,
  //       noticeDate: dateController.text,
  //       priority: selectedPriority,
  //       category: selectedCategory,
  //       targetAudience: selectedAudience,
  //     );

  //     // You can now send `newNotice.toJson()` to your backend
  //     print(newNotice.toJson());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Notice"),
        backgroundColor: Colors.teal,
      ),
      body: Consumer<NoticesProvider>(
        builder: (context, noticesProvider, child) => Form(
          // key: noticesProvider.loginFormKey,
          key: _formKey,
          child: ListView(
            children: [
              CustomTextformfield(
                 
                controller:noticesProvider.titleController,
                labelText: "Title",
                
              ),
              CustomTextformfield(
                labelText: "Content",
               
                  
                controller:noticesProvider.contentController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: CustomDateTimeInput(
                  labelText: "Notice Date",
                  controller: noticesProvider.dateController,
                  pickerType: "date",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Notice Date cannot be empty";
                    }
                    return null;
                  },
                ),
              ),
              CustomDropdown(
                labelText: "Category",
                dropDownItemList: noticesProvider.categoryOptions,
                value: noticesProvider.selectedCategory,
                onChanged: (p0) {
                  noticesProvider.selectedCategory=p0;
                },
              ),
              CustomDropdown(
                labelText: "Priority",
                dropDownItemList: noticesProvider.priorityOptions,
                value: noticesProvider.selectedPriority,
                 onChanged: (p0) {
                  noticesProvider.selectedPriority=p0;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     CustomText(data: "Target Audience",fontWeight: FontWeight.bold),
                    ...noticesProvider.audienceOptions.map((audience) {
                      return CheckboxListTile(
                        title: Text(audience),
                        value: noticesProvider.selectedAudience.contains(audience),
                        onChanged: (val) {
                          setState(() {
                            if (val == true) {
                             noticesProvider. selectedAudience.add(audience);
                            } else {
                              noticesProvider.selectedAudience.remove(audience);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ],
                ),
              ),
              CustomElevatedbutton(
                child: noticesProvider.getAddNoticeStatus==NetworkStatus.loading?Loader.backdropFilter(context):Text("Add Notices"),
                onPressed: () async{
                  if(_formKey.currentState!.validate()){
                   await noticesProvider.addNotice();
                   if(noticesProvider.getAddNoticeStatus==NetworkStatus.success){
                    displaySnackBar(context,addNoticeSuccessStr);
                    _formKey.currentState!.reset();
                    noticesProvider.clearFormFields();
                    RouteGenerator.navigateToPageReplacement(context,Routes.getAssignment);
                   }else{
                    displaySnackBar(context,noticesProvider.errorMsg??addNoticeFailedStr);
                   }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
