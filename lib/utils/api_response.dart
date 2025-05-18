
import 'package:provider_test1/utils/network_status.dart';

class ApiResponse {
  final NetworkStatus? networkStatus;
  final String? errorMessaage;
  final int? statusCode;
  final dynamic data;
  ApiResponse(
    {
      this.data,
      this.errorMessaage,
      this.statusCode,
      this.networkStatus
    }
  );
}