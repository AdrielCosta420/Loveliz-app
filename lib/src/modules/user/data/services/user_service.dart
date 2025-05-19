import '../../../../common/typedef/typedef.dart';

abstract interface class UserService {
  Future<ApiResponse> getUser({required String id});
}