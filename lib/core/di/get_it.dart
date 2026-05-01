import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../constants/api_constant.dart';
import '../constants/dio_helper.dart';
import '../constants/preference_manager.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  DioHelper.init(baseUrl: ApiConstant.baseUrl);
  getIt.registerLazySingleton<Dio>(() => DioHelper.dio);
  getIt.registerLazySingleton<PreferenceManager>(() => PreferenceManager());
}
