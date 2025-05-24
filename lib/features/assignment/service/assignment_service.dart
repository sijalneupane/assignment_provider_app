import 'package:provider_test1/features/assignment/model/add_assignment_model.dart';
import 'package:provider_test1/features/assignment/model/assignment_model.dart';
import 'package:provider_test1/utils/api_response.dart';

abstract class AssignmentService {
  Future<ApiResponse> addAssignment(AddAssignmentModel addAssignmentModel,String token);
  Future<ApiResponse> getAssignment(String token);
  Future<ApiResponse> deleteAssignment(String token,String id);
  Future<ApiResponse> editAssignment(AddAssignmentModel asssignmentModel, String token,String id);
  
}