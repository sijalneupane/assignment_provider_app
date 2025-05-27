import 'dart:io';

import 'package:dio/dio.dart';
import 'package:provider_test1/utils/api_response.dart';
import 'package:provider_test1/utils/network_status.dart';
import 'package:provider_test1/utils/string_const.dart';

class Api {
  Dio dio = Dio();
  Api() {
    dio.options.headers['content-type'] = "application/json";
  }
  Future<ApiResponse> post(String url, var data, {String? token}) async {
    try {
      if (token != null) {
        dio.options.headers['Authorization'] = "Bearer $token";
      }
      Response response = await dio.post(url, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          networkStatus: NetworkStatus.success,
          data: response.data,
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: badRequestStr,
          statusCode: response.statusCode,
        );
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: badRequestStr,
          statusCode: e.response?.statusCode,
        );
      } else if (e.error is SocketException) {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: noInternetStr,
          statusCode: e.response?.statusCode,
        );
      } else if (e.response?.statusCode == 401) {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: e.response?.statusMessage,
          statusCode: e.response?.statusCode,
        );
      } else if (e.response?.statusCode == 403) {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: e.response?.statusMessage,
          statusCode: e.response?.statusCode,
        );
      } else if (e.response?.statusCode == 404) {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: e.response?.statusMessage,
          statusCode: e.response?.statusCode,
        );
      } else {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: e.toString(),
          statusCode: e.response?.statusCode,
        );
      }
    }
  }

  Future<ApiResponse> get(String url, {String? token, dynamic data}) async {
    try {
      if (token != null) {
        dio.options.headers['Authorization'] = "Bearer $token";
      }
      Response response = await dio.get(url,data:data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          networkStatus: NetworkStatus.success,
          data: response.data,
        );
      } else {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: badRequestStr,
        );
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: badRequestStr,
        );
      } else if (e.error is SocketException) {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: noInternetStr,
        );
      } else {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: e.toString(),
        );
      }
    }
  }

  Future<ApiResponse> put(String url, var data, {String? token}) async {
    try {
      if (token != null) {
        dio.options.headers['Authorization'] = "Bearer $token";
      }
      Response response = await dio.put(url, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          networkStatus: NetworkStatus.success,
          data: response.data,
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: badRequestStr,
          statusCode: response.statusCode,
        );
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: badRequestStr,
          statusCode: e.response?.statusCode,
        );
      } else if (e.error is SocketException) {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: noInternetStr,
          statusCode: e.response?.statusCode,
        );
      } else if (e.response?.statusCode == 401) {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: e.response?.statusMessage,
          statusCode: e.response?.statusCode,
        );
      } else if (e.response?.statusCode == 403) {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: e.response?.statusMessage,
          statusCode: e.response?.statusCode,
        );
      } else if (e.response?.statusCode == 404) {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: e.response?.statusMessage,
          statusCode: e.response?.statusCode,
        );
      } else {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: e.toString(),
          statusCode: e.response?.statusCode,
        );
      }
    }
  }

  Future<ApiResponse> patch(String url, var data, {String? token}) async {
    try {
      if (token != null) {
        dio.options.headers['Authorization'] = "Bearer $token";
      }
      Response response = await dio.patch(url, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          networkStatus: NetworkStatus.success,
          data: response.data,
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: badRequestStr,
          statusCode: response.statusCode,
        );
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: badRequestStr,
          statusCode: e.response?.statusCode,
        );
      } else if (e.error is SocketException) {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: noInternetStr,
          statusCode: e.response?.statusCode,
        );
      } else if (e.response?.statusCode == 401) {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: e.response?.statusMessage,
          statusCode: e.response?.statusCode,
        );
      } else if (e.response?.statusCode == 403) {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: e.response?.statusMessage,
          statusCode: e.response?.statusCode,
        );
      } else if (e.response?.statusCode == 404) {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: e.response?.statusMessage,
          statusCode: e.response?.statusCode,
        );
      } else {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: e.toString(),
          statusCode: e.response?.statusCode,
        );
      }
    }
  }

  Future<ApiResponse> delete(String url, {String? token}) async {
    try {
      if (token != null) {
        dio.options.headers['Authorization'] = "Bearer $token";
      }
      Response response = await dio.delete(url);
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return ApiResponse(
          networkStatus: NetworkStatus.success,
          data: response.data,
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: badRequestStr,
          statusCode: response.statusCode,
        );
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: badRequestStr,
          statusCode: e.response?.statusCode,
        );
      } else if (e.error is SocketException) {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: noInternetStr,
          statusCode: e.response?.statusCode,
        );
      } else if (e.response?.statusCode == 401) {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: e.response?.statusMessage,
          statusCode: e.response?.statusCode,
        );
      } else if (e.response?.statusCode == 403) {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: e.response?.statusMessage,
          statusCode: e.response?.statusCode,
        );
      } else if (e.response?.statusCode == 404) {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: e.response?.statusMessage,
          statusCode: e.response?.statusCode,
        );
      } else {
        return ApiResponse(
          networkStatus: NetworkStatus.error,
          errorMessaage: e.toString(),
          statusCode: e.response?.statusCode,
        );
      }
    }
  }
}
