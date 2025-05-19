import '../../../../common/result/result.dart';
import '../errors/user_error.dart';
import '../models/user.dart';

abstract interface class UserRepository {
  Future<Result<UserError, User>> getUser({required String id});
}