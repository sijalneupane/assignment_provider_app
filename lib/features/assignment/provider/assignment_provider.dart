import 'package:flutter/material.dart';
import 'package:provider_test1/features/assignment/model/assignment_model.dart';
import 'package:provider_test1/features/assignment/service/assignment_service.dart';
import 'package:provider_test1/features/assignment/service/assignment_service_impl.dart';
import 'package:provider_test1/utils/api_response.dart';
import 'package:provider_test1/utils/network_status.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken()async{
  final SharedPreferences prefs=await SharedPreferences.getInstance();
  String token=prefs.getString("token") ??'';
  return token;
}
class AssignmentProvider  extends ChangeNotifier{
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

  NetworkStatus _addAssignmentStatus=NetworkStatus.idle;
  NetworkStatus get getAddAssignmentStatus=>_addAssignmentStatus;
  setAddAssignmentStatus(NetworkStatus networkStatus){
    _addAssignmentStatus=networkStatus;
    notifyListeners();
  }

   NetworkStatus _getAssignmentStatus=NetworkStatus.idle;
  NetworkStatus get getGetAssignmentStatus=>_getAssignmentStatus;
  setGetAssignmentStatus(NetworkStatus networkStatus){
    _getAssignmentStatus=networkStatus;
    notifyListeners();
  }
  getAssignment()async{
    // AssignmentModel assignmentModel=AssignmentModel()
    String token=await getToken();
    AssignmentService assignmentService=AssignmentServiceImpl();
    ApiResponse response=await assignmentService.getAssignment( token);
  }

}