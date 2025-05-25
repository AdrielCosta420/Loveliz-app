// import 'dart:typed_data';
import 'dart:typed_data';

import 'api_exception.dart';

import '../../common/typedef/typedef.dart';

import 'package:dio/dio.dart';
import '../../injectable.dart';
import '../../modules/auth/controllers/auth_controller.dart';
import '../constants/constans.dart';
import 'api_request.dart';

class DioApiImpl implements ApiRequest {
  final AuthController auth = injector.get<AuthController>();
  DioApiImpl() {
    _dio.interceptors.add(
      LogInterceptor(
        responseBody: false,
        requestBody: false,
        logPrint: (object) {},
      ),
    );
  }

  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      baseUrl: baseUrl,
    ),
  );

  Future<Map<String, String>> _getHeaders({bool disableToken = false}) async {
    if (disableToken) {
      return {};
    }
    final jwt = auth.token.isEmpty ? null : auth.token;
    return {'Authorization': 'Bearer $jwt', 'Content-Type': 'application/json'};
  }

  @override
  Future<ApiResponse> delete({required String path}) async {
    try {
      final response = await _dio.delete(
        path,
        options: Options(headers: await _getHeaders()),
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiException(e.response?.data['error'], e.response?.statusCode);
    } on Exception catch (e) {
      throw ApiException(e.toString(), 500);
    }
  }

  @override
  Future<ApiResponse> get({
    required String path,
    bool disableToken = false,
     Map<String, dynamic>? queryParameters
  }) async {
    try {
      final response = await _dio.get(
        path,queryParameters: queryParameters,
        options: Options(
          headers: await _getHeaders(disableToken: disableToken),
        ),
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiException(e.response?.data['error'], e.response?.statusCode);
    } on Exception catch (e) {
      throw ApiException(e.toString(), 500);
    }
  }

  @override
  Future<ApiResponse> post({
    required String path,
    required Map<String, dynamic> body,
    bool disableToken = false,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: body,
        options: Options(
          headers: await _getHeaders(disableToken: disableToken),
        ),
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiException(e.message ?? "", e.response?.statusCode);
    } on Exception catch (e) {
      throw ApiException(e.toString(), 500);
    }
  }

  @override
  Future<ApiResponse> postFileData({
    required String path,
    required Uint8List data,
  }) {
    // TODO: implement postFileData
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> put({
    required String path,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: body,
        options: Options(headers: await _getHeaders()),
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiException(e.response?.data['error'], e.response?.statusCode);
    } on Exception catch (e) {
      throw ApiException(e.toString(), 500);
    }
  }
  
  @override
  Future<dynamic> getList({required String path, bool disableToken = false,  Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: await _getHeaders(disableToken: disableToken),
          
        ),
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiException(e.message ?? 'Unkwon error', e.response?.statusCode);
    } on Exception catch (e) {
      throw ApiException(e.toString(), 500);
    }
  }
  
  @override
  Future<ApiResponse> patch({required String path, required Map<String, dynamic> body}) async {
    try {
      final response = await _dio.patch(
        path,
        data: body,
        options: Options(headers: await _getHeaders()),
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiException(e.response?.data['error'], e.response?.statusCode);
    } on Exception catch (e) {
      throw ApiException(e.toString(), 500);
    }
  }
}
