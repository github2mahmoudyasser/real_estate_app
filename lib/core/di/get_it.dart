import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:realstateapp/core/constants/api_constant.dart';
import 'package:realstateapp/core/constants/dio_helper.dart';
import 'package:realstateapp/core/constants/preference_manager.dart';
import 'package:realstateapp/feature/login_screen/data/repo/repoimpl.dart';
import 'package:realstateapp/feature/login_screen/presentation/cubit/login_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  DioHelper.init(baseUrl: ApiConstant.baseUrl);
  getIt.registerLazySingleton<Dio>(() => DioHelper.dio);
  getIt.registerLazySingleton<PreferenceManager>(() => PreferenceManager());

  getIt.registerLazySingleton<AuthRepoImpl>(
        () => AuthRepoImpl(
      preferenceManager: getIt<PreferenceManager>(),
    ),
  );

  //  Login Cubit
  getIt.registerFactory<LoginCubit>(
        () => LoginCubit(getIt<AuthRepoImpl>()),
  );
}

