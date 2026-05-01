import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/booking/data/datasources/booking_remote_datasource.dart';
import '../../features/booking/data/repositories/booking_repository_impl.dart';
import '../../features/booking/domain/repositories/booking_repository.dart';
import '../../features/booking/domain/usecases/create_order_usecase.dart';
import '../../features/booking/domain/usecases/get_property_details_usecase.dart';
import '../../features/booking/presentation/cubit/booking_cubit.dart';
import '../constants/api_constant.dart';
import '../constants/dio_helper.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // External
  sl.registerLazySingleton(() => Dio());

  // Initialize DioHelper with base URL
  DioHelper.init(
    baseUrl: ApiConstant.baseUrl,
    timeout: const Duration(seconds: 30),
    enableLogger: true,
  );

  // ─── Booking Feature ─────────────────────────────────────

  // DataSource
  sl.registerLazySingleton<BookingRemoteDataSource>(
    () => BookingRemoteDataSourceImpl(DioHelper.dio),
  );

  // Repository
  sl.registerLazySingleton<BookingRepository>(
    () => BookingRepositoryImpl(sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetPropertyDetailsUseCase(sl()));
  sl.registerLazySingleton(() => CreateOrderUseCase(sl()));

  // Cubit
  sl.registerFactory(
    () =>
        BookingCubit(getPropertyDetailsUseCase: sl(), createOrderUseCase: sl()),
  );
}
