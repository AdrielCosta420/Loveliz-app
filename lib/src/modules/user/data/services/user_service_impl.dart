import '../../../../common/typedef/typedef.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/api/api_request.dart';
import '../../../../injectable.dart';
import '../../domain/errors/user_error.dart';
import 'user_service.dart';

class UserServiceImpl implements UserService {
  final ApiRequest api = injector.get();

  @override
  Future<ApiResponse> getUser({required String id}) async {
    try {
      return await api.get(path: '/user/single', queryParameters: {'id': id});
    } on ApiException catch (e) {
      throw UserError(message: e.message, code: e.statusCode.toString());
    } on Exception catch (e) {
      throw UserError(message: e.toString());
    }
  }
}
