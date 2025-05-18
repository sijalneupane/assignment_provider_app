import 'package:provider_test1/features/login/model/signup_model.dart';
import 'package:provider_test1/features/login/service/login_service.dart';
import 'package:provider_test1/utils/api.dart';
import 'package:provider_test1/utils/api_const.dart';
import 'package:provider_test1/utils/api_response.dart';

class LoginServiceImpl extends LoginSerice{
  Api api= Api();
  @override
  Future<ApiResponse> login(SignupModel signupModel)async {
    
    ApiResponse apiResponse=await api.post(ApiConst.baseUrl+ ApiConst.signUpApi, signupModel.toJson());
    return apiResponse;
  }
  
  @override
  Future<String> getName(String name) async{
    return "sijal";
  }
}