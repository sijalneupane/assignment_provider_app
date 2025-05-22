import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test1/features/assignment/model/add_assignment_model.dart';
import 'package:provider_test1/features/assignment/model/assignment_model.dart';
import 'package:provider_test1/features/assignment/provider/assignment_provider.dart';
import 'package:provider_test1/utils/api_const.dart';
import 'package:provider_test1/utils/network_status.dart';
import 'package:provider_test1/utils/route_const.dart';
import 'package:provider_test1/utils/route_generator.dart';
import 'package:provider_test1/utils/snackbar.dart';
import 'package:provider_test1/utils/string_const.dart';
import 'package:provider_test1/widgets/custom_dropdown.dart';
import 'package:provider_test1/widgets/custom_elevatedbutton.dart';
import 'package:provider_test1/widgets/custom_textformfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAssignment extends StatefulWidget {
  AssignmentModel? assignmentModel;
  AddAssignment({super.key, this.assignmentModel});

  @override
  State<AddAssignment> createState() => _AddAssignmentState();
}

class _AddAssignmentState extends State<AddAssignment> {
  @override
  void initState() {
    if (widget.assignmentModel != null) {
      Future.microtask(() {
      Provider.of<AssignmentProvider>(context, listen: false).setFormValues(widget.assignmentModel!);
    });
    }
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(addAssignmentStr),
      ),
      body: Consumer<AssignmentProvider>(
        builder:
            (context, assignmentProvider, child) => SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextformfield(
                      labelText: subjectNameStr,
                      controller: assignmentProvider.subjectController,
                    ),
                    CustomDropdown(
                      value: assignmentProvider.faculty,
                      dropDownItemList: assignmentProvider.facultyList,
                      labelText: facultyStr,
                      onChanged: (value) {
                        assignmentProvider.faculty = value;
                      },
                    ),
                    CustomDropdown(
                      value: assignmentProvider.semester,
                      dropDownItemList: assignmentProvider.semesterList,
                      labelText: semesterStr,
                      onChanged: (value) {
                        assignmentProvider.semester = value;
                      },
                    ),
                    CustomTextformfield(
                      labelText: titleStr,
                      controller: assignmentProvider.titleController,
                    ),
                    CustomTextformfield(
                      labelText: descriptionStr,
                      controller: assignmentProvider.descriptionController,
                    ),
                    CustomElevatedbutton(
                      child: Text(addAssignmentStr),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          assignmentProvider.setAddAssignmentStatus(
                            NetworkStatus.loading,
                          );
                          if (widget.assignmentModel == null) {
                            await assignmentProvider.addAssignment();
                            if (assignmentProvider.getAddAssignmentStatus ==
                                NetworkStatus.success) {
                              displaySnackBar(context, addAssignmentMessageStr);
                              Future.delayed(Duration(seconds: 1), () {
                                // RouteGenerator.navigateToPage(context,Routes.)
                                RouteGenerator.navigateToPage(
                                  context,
                                  Routes.getAssignment,
                                );
                              });
                            } else {
                              displaySnackBar(
                                context,
                                addAssignmentMessageFailedStr,
                              );
                            }
                          } else {
                            await assignmentProvider.editAssignment(
                              widget.assignmentModel!.id!,
                            );
                            if (assignmentProvider.getEditAssignmentStatus ==
                                NetworkStatus.success) {
                              displaySnackBar(
                                context,
                                editAssignmentMessageStr,
                              );
                              Future.delayed(Duration(seconds: 1), () {
                                // RouteGenerator.navigateToPage(context,Routes.)
                                RouteGenerator.navigateToPage(
                                  context,
                                  Routes.getAssignment,
                                );
                              });
                            } else {
                              displaySnackBar(
                                context,
                                editAssignmentMessageFailedStr,
                              );
                            }
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
