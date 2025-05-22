import 'package:flutter/material.dart';
import 'package:provider_test1/features/assignment/model/add_assignment_model.dart';
import 'package:provider_test1/features/assignment/model/assignment_model.dart';
import 'package:provider_test1/features/assignment/service/assignment_service.dart';
import 'package:provider_test1/features/assignment/service/assignment_service_impl.dart';
import 'package:provider_test1/utils/api.dart';
import 'package:provider_test1/utils/api_const.dart';
import 'package:provider_test1/utils/api_response.dart';
import 'package:provider_test1/utils/get_token_role.dart';
import 'package:provider_test1/utils/network_status.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Future<String> getToken() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   String token = prefs.getString("token") ?? '';
//   return token;
// }

class AssignmentProvider extends ChangeNotifier {
  // AssignmentProvider(){
  //   getAssignment();
  // }
  void clearFormFields() {
    subjectController.clear();
    titleController.clear();
    descriptionController.clear();
    faculty = null;
    semester = null;
    assignmentList = [];
    notifyListeners();
  }

setFormValues(AssignmentModel assignmentModel) {
  subjectController.text = assignmentModel.subjectName!;
  titleController.text = assignmentModel.title !;
  descriptionController.text = assignmentModel.description !;
  faculty = assignmentModel.faculty!;

semester = assignmentModel.semester!;
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
    setAddAssignmentStatus(NetworkStatus.loading);
    AssignmentServiceImpl assignmentServiceImpl = AssignmentServiceImpl();
    String token = await GetTokenRole().getToken();
    AddAssignmentModel addAssignmentModel = AddAssignmentModel(
      title: titleController.text,
      subjectName: subjectController.text,
      faculty: faculty,
      semester: semester,
      description: descriptionController.text,
    );
    ApiResponse response = await assignmentServiceImpl.addAssignment(
      addAssignmentModel,
      token,
    );
    if (response.networkStatus == NetworkStatus.success) {
      setAddAssignmentStatus(NetworkStatus.success);
      clearFormFields();
    } else {
      setAddAssignmentStatus(NetworkStatus.error);
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
    // AddAssignmentModel AddAssignmentModel=AddAssignmentModel()
    setGetAssignmentStatus(NetworkStatus.loading);
    String token = await GetTokenRole().getToken();
    AssignmentService assignmentService = AssignmentServiceImpl();
    ApiResponse response = await assignmentService.getAssignment(token);
    if (response.networkStatus == NetworkStatus.success) {
      List assignments = response.data;
      assignmentList =
          assignments.map((e) {
            var assignment = AssignmentModel.fromJson(e);
            return assignment;
          }).toList();
      setGetAssignmentStatus(NetworkStatus.success);
      notifyListeners();
    } else {
      setGetAssignmentStatus(NetworkStatus.error);
    }
  }

  //deleteassigment
  NetworkStatus _deleteAssignmentStatus = NetworkStatus.idle;
  NetworkStatus get getDeleteAssignmentStatus => _deleteAssignmentStatus;
  setDeleteAssignmentStatus(NetworkStatus networkStatus) {
    _getAssignmentStatus = networkStatus;
    notifyListeners();
  }

  deleteAssignmentById(String id) async {
    setDeleteAssignmentStatus(NetworkStatus.loading);
    AssignmentService apiService = AssignmentServiceImpl();
    String token = await GetTokenRole().getToken();
    ApiResponse response = await apiService.deleteAssignment(token, id);
    if (response.networkStatus == NetworkStatus.success) {
      await getAssignment();
      setDeleteAssignmentStatus(NetworkStatus.success);
    } else {
      setDeleteAssignmentStatus(NetworkStatus.error);
    }
  }

  //edit assignment
  NetworkStatus _editAssignmentStatus = NetworkStatus.idle;
  NetworkStatus get getEditAssignmentStatus => _editAssignmentStatus;
  setEditAssignmentStatus(NetworkStatus networkStatus) {
    _editAssignmentStatus = networkStatus;
    notifyListeners();
  }

  editAssignment(String id) async {
    setEditAssignmentStatus(NetworkStatus.loading);
    AssignmentService assignmentServiceImpl = AssignmentServiceImpl();
    String token = await GetTokenRole().getToken();
    AssignmentModel assignmentModel = AssignmentModel(
      id: id,
      title: titleController.text,
      subjectName: subjectController.text,
      faculty: faculty,
      semester: semester,
      description: descriptionController.text,
    );
    ApiResponse response = await assignmentServiceImpl.editAssignment(
      assignmentModel,
      token,
      id,
    );
    if(response.networkStatus==NetworkStatus.success){
      setEditAssignmentStatus(NetworkStatus.success);

    }else{
      setEditAssignmentStatus(NetworkStatus.error);
    }
  }
}
