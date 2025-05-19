import '../../../../common/snackbar/snackbar_custom.dart';
import '../../../../injectable.dart';
import '../../presentation/controllers/user_controller.dart';
import '../repositories/user_repository.dart';

abstract interface class GetUserUc {
  Future<void> call({required String id});
}

class GetUserUcImpl implements GetUserUc {
  final UserRepository userRepository = injector.get();
  final UserController userController = injector.get();

  @override
  Future<void> call({required String id}) async {
    final response = await userRepository.getUser(id: id);
    response.fold(
      (error) =>
          SnackbarCustom.failure('Ocorreu um erro ao buscar informações.'),
      (success) {
        userController.setUser(success);
      },
    );
  }
}
