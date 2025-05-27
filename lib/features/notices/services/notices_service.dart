import 'package:provider_test1/features/notices/model/add_notices_model.dart';
import 'package:provider_test1/utils/api_response.dart';

abstract class NoticesService {
  Future<ApiResponse> addNotices( String token, AddNoticesModel addNoticeModel);
  Future<ApiResponse> getNotices( String token);
  Future<ApiResponse> getNoticesById( String token,String id);
  Future<ApiResponse> editNotices( String token, AddNoticesModel addNoticeModel,String id);
  Future<ApiResponse> deleteNotices( String token,String id);
} 