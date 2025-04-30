
import 'package:loveliz_app/src/common/result/result.dart';
import 'package:loveliz_app/src/common/typedef/typedef.dart';
import 'package:loveliz_app/src/injectable.dart';
import 'package:loveliz_app/src/modules/auth/services/auth_service.dart';

import '../../../core/api/api_exception.dart';
import '../dtos/credentials.dart';

import '../errors/auth_error.dart';

abstract interface class AuthRepository {
  Future<Result<AuthError, AccessToken>> login({required Credentials credentials});
}

class AuthRepositoryImpl implements AuthRepository {
  final service = injector.get<AuthService>();

  @override
  Future<Result<AuthError, AccessToken>> login({required Credentials credentials}) async {
    try {
      final response = await service.login(credentials: credentials);
      return Result.success((response)['token']);
    } on ApiException catch (e) {
      return Result.failure(AuthError(message: e.message));
    } on Exception catch (e) {
      return Result.failure(AuthError(message: e.toString()));
    }
  }
}
