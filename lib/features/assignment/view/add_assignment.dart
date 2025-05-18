
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
  String? semester, faculty;
  TextEditingController subjectController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<String> facultyList = ["BCA", "BIM", "CSIT"];
  List<String> semesterList = [
    "First Semester",
    "Second Semester",
    "Third Semester",
    "Fourth Semester",
    "Fifth Semester",
    "Sixth Semester",
    "Seven Semester",
    "Eight Semester"
  ];

  String? token;

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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextformfield(
                labelText: subjectNameStr,
                controller: subjectController,
              ),
              CustomDropdown(
                dropDownItemList: facultyList,
                labelText: facultyStr,
                onChanged: (value) {
                  faculty = value;
                },
              ),
              CustomDropdown(
                dropDownItemList: semesterList,
                labelText: semesterStr,
                onChanged: (value) {
                  semester = value;
                },
              ),
              CustomTextformfield(
                labelText: titleStr,
                controller: titleController,
              ),
              CustomTextformfield(
                  labelText: descriptionStr, controller: descriptionController),
              CustomElevatedbutton(
                  child: Text(
                    addAssignmentStr,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var addAssignmentJson = {
                        "subjectName": subjectController.text,
                        "semester": semester,
                        "faculty": faculty,
                        "title": titleController.text,
                        "description": descriptionController.text
                      };
                      Dio dio = Dio();
                      try {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        token = prefs.getString("authToken");
                        dio.options.headers['content-Type'] =
                            'application/json';
                        if (token != null && token!.isNotEmpty) {
                          dio.options.headers["Authorization"] =
                              "Bearer $token";
                        }
                        Response response = await dio.post(
                            ApiConst.baseUrl + ApiConst.addAssignmentApi,
                            data: addAssignmentJson);
                        if (response.statusCode == 200 ||
                            response.statusCode == 201) {
                          subjectController.clear();
                          semester = null;
                          faculty = null;
                          titleController.clear();
                          descriptionController.clear();
                          _formKey.currentState!.reset();
                          displaySnackBar(context, addAssignmentMessageStr);
                        } else {
                          displaySnackBar(
                              context, addAssignmentMessageFailedStr);
                        }
                      } catch (e) {
                        displaySnackBar(context, e.toString());
                      }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
