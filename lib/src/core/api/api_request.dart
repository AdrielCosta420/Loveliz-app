import 'dart:typed_data';

import '../../common/typedef/typedef.dart';

abstract interface class ApiRequest {
  Future<ApiResponse> get({required String path, bool disableToken = false,  Map<String, dynamic>? queryParameters});
  Future<dynamic> getList({required String path, bool disableToken = false, Map<String, dynamic>? queryParameters});
  Future<ApiResponse> post({
    required String path,
    required Map<String, dynamic> body,
    bool disableToken = false,
  });
  Future<ApiResponse> put({
    required String path,
    required Map<String, dynamic> body,
  });
  Future<ApiResponse> patch({
    required String path,
    required Map<String, dynamic> body,
  });
  Future<ApiResponse> delete({required String path});
  Future<ApiResponse> postFileData({
    required String path,
    required Uint8List data,
  });
}
