import 'package:provider_test1/features/assignment/model/assignment_model.dart';
import 'package:provider_test1/utils/api_response.dart';

abstract class AssignmentService {
  Future<ApiResponse> addAssignment(AssignmentModel assignmentModel,String token);
  Future<ApiResponse> getAssignment(String token);
  
}