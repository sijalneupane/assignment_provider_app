import 'package:provider_test1/features/assignment/model/assignment_model.dart';
import 'package:provider_test1/features/assignment/service/assignment_service.dart';
import 'package:provider_test1/utils/api.dart';
import 'package:provider_test1/utils/api_const.dart';
import 'package:provider_test1/utils/api_response.dart';

class AssignmentServiceImpl extends AssignmentService{
  Api api=new Api();
  @override
  Future<ApiResponse> addAssignment(AssignmentModel assignmentModel, String token) async {
    ApiResponse response=await api.post(ApiConst.baseUrl+ApiConst.addAssignmentApi,assignmentModel, token: token);
    return response;
  }

  @override
  Future<ApiResponse> getAssignment(String token) async {
   ApiResponse response=await api.get(ApiConst.baseUrl+ApiConst.addAssignmentApi, token: token);
    return response;
  }
}