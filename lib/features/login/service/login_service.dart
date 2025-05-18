import 'package:provider_test1/features/login/model/signup_model.dart';
import 'package:provider_test1/utils/api_response.dart';

abstract class LoginSerice{
  Future<ApiResponse> login(SignupModel signupModel);
  Future<String> getName(String name);
}