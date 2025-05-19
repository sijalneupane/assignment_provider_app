import 'package:provider_test1/features/login/model/login_model.dart';
import 'package:provider_test1/features/login/model/signup_model.dart';
import 'package:provider_test1/utils/api_response.dart';

abstract class LoginRegisterSerice{
  Future<ApiResponse> register(SignupModel signupModel);
  Future<ApiResponse> login(LoginModel signupModel);
  Future<String> getName(String name);
}