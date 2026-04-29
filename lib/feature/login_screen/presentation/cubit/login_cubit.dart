import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../../../core/constants/preference_manager.dart';
import '../../../../core/constants/storage_keys.dart';
import '../../data/repo/repoimpl.dart';
import 'login_state.dart';


class LoginCubit extends Cubit<AuthStates> {
  final AuthRepoImpl loginRepoImpl;

  LoginCubit(this.loginRepoImpl) : super(AuthInitialState());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoadingState());

    try {
      final result = await loginRepoImpl.login(
          email: email,
          password: password
      );

      final token = result?.data?.token;

      if (token != null) {
        // بنستخدم الـ Instance اللي متسجلة في الـ GetIt أو نكريت واحدة لو مش Injectable
        await PreferenceManager().setString(StorageKeys.authToken, token);
      }

      emit(AuthSuccessState(result!));
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data != null && data['errors'] != null) {
        final errors = data['errors'] as Map<String, dynamic>;
        final firstError = errors.values.first[0];
        emit(AuthErrorState(firstError));
      } else {
        emit(AuthErrorState(data?['message'] ?? 'Login failed. Please check your credentials.'));
      }
    } catch (e) {
      emit(AuthErrorState("Something went wrong: ${e.toString()}"));
    }
  }
}