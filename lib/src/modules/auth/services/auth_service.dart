import 'package:loveliz_app/src/common/typedef/typedef.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/api/api_request.dart';
import '../../../injectable.dart';
import '../dtos/credentials.dart';
import '../errors/auth_error.dart';

abstract interface class AuthService {
  Future<ApiResponse> login({required Credentials credentials});
}

class AuthServiceImpl implements AuthService {
  final api = injector.get<ApiRequest>();

  @override
  Future<ApiResponse> login({required Credentials credentials}) async {
    try {
      return await api.post(path: '/auth', body: credentials.toMap(), disableToken: true);
    } on ApiException catch (e) {
      throw AuthError(message: e.message);
    } on Exception catch (e) {
      throw AuthError(message: e.toString());
    }
  }
}
