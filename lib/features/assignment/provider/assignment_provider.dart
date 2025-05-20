import 'package:flutter/material.dart';
import 'package:provider_test1/features/assignment/model/assignment_model.dart';
import 'package:provider_test1/features/assignment/service/assignment_service.dart';
import 'package:provider_test1/features/assignment/service/assignment_service_impl.dart';
import 'package:provider_test1/utils/api.dart';
import 'package:provider_test1/utils/api_const.dart';
import 'package:provider_test1/utils/api_response.dart';
import 'package:provider_test1/utils/network_status.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("token") ?? '';
  return token;
}

class AssignmentProvider extends ChangeNotifier {
  void clearFormFields() {
    subjectController.clear();
    titleController.clear();
    descriptionController.clear();
    faculty = null;
    semester = null;
    notifyListeners();
  }

  String? semester, faculty;
  List assignmentList = [];
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
    "Eight Semester",
  ];

  // String? token;

  
//addding assignment
  NetworkStatus _addAssignmentStatus = NetworkStatus.idle;
  NetworkStatus get getAddAssignmentStatus => _addAssignmentStatus;
  setAddAssignmentStatus(NetworkStatus networkStatus) {
    _addAssignmentStatus = networkStatus;
    notifyListeners();
  }

  addAssignment() async {
    AssignmentServiceImpl assignmentServiceImpl = AssignmentServiceImpl();
    String token = await getToken();
    setAddAssignmentStatus(NetworkStatus.loading);
    AssignmentModel assignmentModel = AssignmentModel(
      title: titleController.text,
      subjectName: subjectController.text,
      faculty: faculty,
      semester: semester,
      description: descriptionController.text,
    );
    ApiResponse response = await assignmentServiceImpl.addAssignment(
      assignmentModel,
      token,
    );
    if (response.networkStatus == NetworkStatus.success) {
      setGetAssignmentStatus(NetworkStatus.success);
    }
  }

  //getting assigment
  NetworkStatus _getAssignmentStatus = NetworkStatus.idle;
  NetworkStatus get getGetAssignmentStatus => _getAssignmentStatus;
  setGetAssignmentStatus(NetworkStatus networkStatus) {
    _getAssignmentStatus = networkStatus;
    notifyListeners();
  }

  getAssignment() async {
    // AssignmentModel assignmentModel=AssignmentModel()
    String token = await getToken();
    AssignmentService assignmentService = AssignmentServiceImpl();
    ApiResponse response = await assignmentService.getAssignment(token);
    if (response.networkStatus == NetworkStatus.success) {
      assignmentList = response.data;
    }
  }
}
