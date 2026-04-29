
import '../model/user_model.dart';

abstract class AuthRepo {
  Future<LoginModel?> login({required String email, required String password});
}