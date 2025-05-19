import '../../../../common/result/result.dart';

import '../../domain/errors/user_error.dart';

import '../../domain/models/user.dart';

import '../../../../injectable.dart';
import '../../domain/repositories/user_repository.dart';
import '../services/user_service.dart';

class UserRepositoryImpl implements UserRepository {
  final UserService service = injector.get();

  @override
  Future<Result<UserError, User>> getUser({required String id}) async {
    try {
      return Result.success(User.fromMap(await service.getUser(id: id)));
    } on UserError catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UserError(message: e.toString()));
    }
  }
}
