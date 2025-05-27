import 'package:provider_test1/features/notices/model/add_notices_model.dart';
import 'package:provider_test1/features/notices/services/notices_service.dart';
import 'package:provider_test1/utils/api.dart';
import 'package:provider_test1/utils/api_const.dart';
import 'package:provider_test1/utils/api_response.dart';

class NoticesServiceImpl extends NoticesService{
  Api api=Api();
  @override
  Future<ApiResponse> addNotices(String token, AddNoticesModel addNoticeModel)async {
    String url=ApiConst.baseUrl+ApiConst.noticesApi;
   ApiResponse response=await api.post(url, addNoticeModel,token: token);
   return response;
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> getNotices( String token)async {
    String url=ApiConst.baseUrl+ApiConst.noticesApi;
    ApiResponse response=await api.get(url,token: token);
    return response;
    // TODO: implement getNotices
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> deleteNotices( String token,String id)async {
    String url="${ApiConst.baseUrl +ApiConst.noticesApi}/$id/";
    ApiResponse response=await api.delete(url,token: token);
    return response;
    // TODO: implement deleteNotices
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> editNotices( String token, AddNoticesModel addNoticeModel,String id)async{
    String url="${ApiConst.baseUrl +ApiConst.noticesApi}/$id/";
    ApiResponse response=await api.put(url, addNoticeModel,token: token);
    return response;
    // TODO: implement editNotices
    throw UnimplementedError();
  }
  
  @override
  Future<ApiResponse> getNoticesById(String token, String id)async {
    String url="${ApiConst.baseUrl +ApiConst.noticesApi}/$id/";
    ApiResponse response=await api.get(url,token: token);
    return response;
    // TODO: implement getNoticesById
    throw UnimplementedError();
  }

}