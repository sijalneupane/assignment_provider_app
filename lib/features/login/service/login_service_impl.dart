import 'package:provider_test1/features/login/model/login_model.dart';
import 'package:provider_test1/features/login/model/signup_model.dart';
import 'package:provider_test1/features/login/service/login_service.dart';
import 'package:provider_test1/utils/api.dart';
import 'package:provider_test1/utils/api_const.dart';
import 'package:provider_test1/utils/api_response.dart';

class LoginServiceImpl extends LoginRegisterSerice{
  Api api= Api();
  @override
  Future<ApiResponse> register(SignupModel signupModel)async {
    
    ApiResponse apiResponse=await api.post(ApiConst.baseUrl+ ApiConst.signUpApi, signupModel.toJson());
    return apiResponse;
  }
  
  @override
  Future<String> getName(String name) async{
    return "sijal";
  }
  
  @override
  Future<ApiResponse> login(LoginModel loginModel)async {
    ApiResponse apiResponse=await api.post(ApiConst.baseUrl+ ApiConst.loginApi, loginModel.toJson());
    return apiResponse;
  }
}