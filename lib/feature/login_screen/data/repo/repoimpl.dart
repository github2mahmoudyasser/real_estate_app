
import 'package:realstateapp/feature/login_screen/data/model/user_model.dart';
import 'package:realstateapp/feature/login_screen/data/repo/repo.dart';
import '../../../../core/constants/dio_helper.dart';
import '../../../../core/constants/preference_manager.dart';
import '../../../../core/constants/api_constant.dart';
import '../../../../core/constants/storage_keys.dart';

class AuthRepoImpl implements AuthRepo {
  final PreferenceManager preferenceManager;

  AuthRepoImpl({required this.preferenceManager});

  LoginModel? _currentUser;

  Future<LoginModel?> _auth(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await DioHelper.post(path: endPoint, data: body);

      if (response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        final loginResponse = LoginModel.fromJson(responseData);

        final String? token = loginResponse.data?.token;

        if (token != null) {
          await preferenceManager.setString(StorageKeys.authToken, token);
          await preferenceManager.setString('token', token);
        }

        _currentUser = loginResponse;
        return loginResponse;
      } else {
        throw "Unexpected response format";
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LoginModel?> login({
    required String email,
    required String password,
  }) async {
    return _auth(ApiConstant.login, {"email": email, "password": password});
  }

  LoginModel? get currentUser => _currentUser;
}