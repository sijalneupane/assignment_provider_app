
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test1/features/assignment/provider/assignment_provider.dart';
import 'package:provider_test1/utils/api_const.dart';
import 'package:provider_test1/utils/snackbar.dart';
import 'package:provider_test1/utils/string_const.dart';
import 'package:provider_test1/widgets/custom_dropdown.dart';
import 'package:provider_test1/widgets/custom_elevatedbutton.dart';
import 'package:provider_test1/widgets/custom_textformfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAssignment extends StatefulWidget {
  const AddAssignment({super.key});

  @override
  State<AddAssignment> createState() => _AddAssignmentState();
}

class _AddAssignmentState extends State<AddAssignment> {


  // @override
  // void initState() {
  //   fetchToken();
  //   super.initState();

  // }

  // fetchToken() async {
  //   try {
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     setState(() {
  //       token = prefs.getString('authToken'); // Retrieve the token
  //     });
  //   } on Exception catch (e) {
  //     displaySnackBar(context, e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
        title: Text(addAssignmentStr),
      ),
      body: Consumer<AssignmentProvider>(
        builder: (context, assignmentProvider, child) =>  SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextformfield(
                  labelText: subjectNameStr,
                  controller: assignmentProvider.subjectController,
                ),
                CustomDropdown(
                  dropDownItemList:assignmentProvider.facultyList,
                  labelText: facultyStr,
                  onChanged: (value) {
                    assignmentProvider.faculty=value;
                  },
                ),
                CustomDropdown(
                  dropDownItemList:assignmentProvider. semesterList,
                  labelText: semesterStr,
                  onChanged: (value) {
                    assignmentProvider.semester = value;
                  },
                ),
                CustomTextformfield(
                  labelText: titleStr,
                  controller:assignmentProvider.titleController,
                ),
                CustomTextformfield(
                    labelText: descriptionStr, controller:assignmentProvider. descriptionController),
                CustomElevatedbutton(
                    child: Text(
                      addAssignmentStr,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // var addAssignmentJson = {
                        //   "subjectName": subjectController.text,
                        //   "semester": semester,
                        //   "faculty": faculty,
                        //   "title": titleController.text,
                        //   "description": descriptionController.text
                        // };
                        // Dio dio = Dio();
                        // try {
                        //   final SharedPreferences prefs =
                        //       await SharedPreferences.getInstance();
                        //   token = prefs.getString("authToken");
                        //   dio.options.headers['content-Type'] =
                        //       'application/json';
                        //   if (token != null && token!.isNotEmpty) {
                        //     dio.options.headers["Authorization"] =
                        //         "Bearer $token";
                        //   }
                        //   Response response = await dio.post(
                        //       ApiConst.baseUrl + ApiConst.addAssignmentApi,
                        //       data: addAssignmentJson);
                        //   if (response.statusCode == 200 ||
                        //       response.statusCode == 201) {
                        //     subjectController.clear();
                        //     semester = null;
                        //     faculty = null;
                        //     titleController.clear();
                        //     descriptionController.clear();
                        //     _formKey.currentState!.reset();
                        //     displaySnackBar(context, addAssignmentMessageStr);
                        //   } else {
                        //     displaySnackBar(
                        //         context, addAssignmentMessageFailedStr);
                        //   }
                        // } catch (e) {
                        //   displaySnackBar(context, e.toString());
                        // }
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
