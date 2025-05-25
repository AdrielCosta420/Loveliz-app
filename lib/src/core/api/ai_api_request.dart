
import '../../common/typedef/typedef.dart';

abstract interface class AIApiRequest {
  Future<ApiResponse> post({
    required String path,
    required Map<String, dynamic> body,
    bool disableToken = false,
  });
}
