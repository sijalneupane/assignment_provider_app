import 'package:provider_test1/features/assignment/model/add_assignment_model.dart';
import 'package:provider_test1/features/assignment/model/assignment_model.dart';
import 'package:provider_test1/features/assignment/service/assignment_service.dart';
import 'package:provider_test1/utils/api.dart';
import 'package:provider_test1/utils/api_const.dart';
import 'package:provider_test1/utils/api_response.dart';

class AssignmentServiceImpl extends AssignmentService{
  Api api=new Api();
  @override
  Future<ApiResponse> addAssignment(AddAssignmentModel addAssignmentModel, String token) async {
    ApiResponse response=await api.post(ApiConst.baseUrl+ApiConst.addAssignmentApi,addAssignmentModel, token: token);
    return response;
  }

  @override
  Future<ApiResponse> getAssignment(String token) async {
   ApiResponse response=await api.get(ApiConst.baseUrl+ApiConst.getAssignmentApi, token: token);
    return response;
  }
  
  @override
  Future<ApiResponse> deleteAssignment(String token, String id) async{
    String url="${ApiConst.baseUrl+ApiConst.deleteAssignmentApi}$id/";
   ApiResponse response=await api.delete(url,token: token);
   return response;
   }
   
     @override
     Future<ApiResponse> editAssignment(AssignmentModel editAsssignmentModel, String token,String id)async {
    String url="${ApiConst.baseUrl+ApiConst.editAssignmentApi}$id/";
      ApiResponse response=await api.put(ApiConst.baseUrl, editAsssignmentModel);
      return response;
     }
}