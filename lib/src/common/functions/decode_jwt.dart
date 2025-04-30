import 'package:jwt_decoder/jwt_decoder.dart';

sealed class DecodeJwt {
  static decode(String token) {
    return JwtDecoder.decode(token);
  }
}