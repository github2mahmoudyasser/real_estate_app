import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:realstateapp/core/constants/api_constant.dart';
import 'package:realstateapp/core/constants/dio_helper.dart';
import 'package:realstateapp/core/constants/preference_manager.dart';
import 'package:realstateapp/feature/login_screen/data/repo/repoimpl.dart';
import 'package:realstateapp/feature/login_screen/presentation/cubit/login_cubit.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  DioHelper.init(baseUrl: ApiConstant.baseUrl);
  sl.registerLazySingleton<Dio>(() => DioHelper.dio);
  sl.registerLazySingleton<PreferenceManager>(() => PreferenceManager());

  sl.registerLazySingleton<AuthRepoImpl>(
        () => AuthRepoImpl(
      preferenceManager: sl<PreferenceManager>(),
    ),
  );

  sl.registerFactory<LoginCubit>(
        () => LoginCubit(sl<AuthRepoImpl>()),
  );
}

