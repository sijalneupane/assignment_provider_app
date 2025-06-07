import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test1/features/assignment/model/add_assignment_model.dart';
import 'package:provider_test1/features/assignment/model/assignment_model.dart';
import 'package:provider_test1/features/assignment/provider/assignment_provider.dart';
import 'package:provider_test1/utils/api_const.dart';
import 'package:provider_test1/utils/hide_keyboard.dart';
import 'package:provider_test1/utils/network_status.dart';
import 'package:provider_test1/utils/route_const.dart';
import 'package:provider_test1/utils/route_generator.dart';
import 'package:provider_test1/utils/snackbar.dart';
import 'package:provider_test1/utils/spin_kit.dart';
import 'package:provider_test1/utils/string_const.dart';
import 'package:provider_test1/widgets/custom_app_bar.dart';
import 'package:provider_test1/widgets/custom_dropdown.dart';
import 'package:provider_test1/widgets/custom_elevatedbutton.dart';
import 'package:provider_test1/widgets/custom_text.dart';
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
    // WidgetsBinding.instance.addPostFrameCallback((_) {
      final assignmentProvider = Provider.of<AssignmentProvider>(context, listen: false);
      if (widget.assignmentModel != null) {
        assignmentProvider.setFormValues(widget.assignmentModel!);
      } else {
        assignmentProvider.clearFormFields();
      }
    // });
    super.initState();
  }

  // final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AssignmentProvider>(
        builder:
            (context, assignmentProvider, child) => Stack(
              children: [
                _ui(assignmentProvider),
                assignmentProvider.getAddAssignmentStatus ==NetworkStatus.loading || assignmentProvider.getEditAssignmentStatus ==NetworkStatus.loading ?Loader.backdropFilter(context) : SizedBox(),
              ],
            )
      ),
    );
  }
  Widget _ui(AssignmentProvider assignmentProvider){
    return SafeArea(
      child: RefreshIndicator.adaptive(
        onRefresh: () async {
            assignmentProvider.clearFormFields();
          },
        child: ListView(
          children: [
            Form(
              key:
                  widget.assignmentModel != null
                      ? assignmentProvider.updateformKey
                      : assignmentProvider.addformKey,
              child: Column(
                children: [
                  CustomAppBar(
                    hasBackButton: true,
                    middleChild: CustomText(
                      data:
                          widget.assignmentModel == null
                              ? addAssignmentStr
                              : editAssignmentStr,
                      isFormTitle: true,
                    ),
                  ),
                  SizedBox(height: 100),
                  CustomTextformfield(
                    labelText: subjectNameStr,
                    controller: assignmentProvider.subjectController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter subject name";
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter title";
                      }
                      return null;
                    },
                  ),
                  CustomTextformfield(
                    labelText: descriptionStr,
                    controller: assignmentProvider.descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter description";
                      }
                      return null;
                    },
                  ),
                  CustomElevatedbutton(
                    child: Text(
                      widget.assignmentModel == null
                          ? addAssignmentStr
                          : editAssignmentStr,
                    ),
                    onPressed: () async {
                      HideKeyboard.hideKeyboard(context);
                      if (widget.assignmentModel == null) {
                        // ADD assignment case
                        if (assignmentProvider.addformKey.currentState!.validate()) {
                          assignmentProvider.setAddAssignmentStatus(
                            NetworkStatus.loading,
                          );
                          await assignmentProvider.addAssignment();
                
                          if (assignmentProvider.getAddAssignmentStatus ==
                              NetworkStatus.success) {
                            displaySnackBar(
                              context,
                              addAssignmentMessageStr,
                            );
                              RouteGenerator.navigateToPageReplacement(
                                context,
                                Routes.getAssignment,
                              );
                          } else {
                            displaySnackBar(
                              context,
                              addAssignmentMessageFailedStr,
                            );
                          }
                        }
                      } else {
                        // EDIT assignment case
                        if (assignmentProvider.updateformKey.currentState!
                            .validate()) {
                          assignmentProvider.setEditAssignmentStatus(
                            NetworkStatus.loading,
                          );
                          await assignmentProvider.editAssignment(
                            widget.assignmentModel!.id!.toString(),
                          );
                
                          if (assignmentProvider.getEditAssignmentStatus ==
                              NetworkStatus.success) {
                            displaySnackBar(
                              context,
                              editAssignmentMessageStr,
                            );
                            
                              Navigator.pop(context);
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
          ],
        ),
      ),
    );
  }
}
