

import 'ai_api_request.dart';

import 'api_exception.dart';

import '../../common/typedef/typedef.dart';

import 'package:dio/dio.dart';
import '../../injectable.dart';
import '../../modules/auth/controllers/auth_controller.dart';
import '../constants/constans.dart';

class AIDioApiImpl implements AIApiRequest {
 

  final AuthController auth = injector.get<AuthController>();
  AIDioApiImpl() {
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
      baseUrl: baseUrlAgentAI,
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


}
