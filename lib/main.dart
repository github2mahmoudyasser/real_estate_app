import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/app_router/app_router.dart';
import 'core/constants/api_constant.dart';
import 'core/constants/bloc_abserver.dart';
import 'core/constants/dio_helper.dart';
import 'core/constants/preference_manager.dart';
import 'core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupServiceLocator();

  // Initialize SharedPreferences
  await sl< PreferenceManager>().init();
   //Initialize ScreenUtil
  await ScreenUtil.ensureScreenSize();

  final AppRouter appRouter = AppRouter();

  // Initialize Dio
  DioHelper.init(baseUrl: ApiConstant.baseUrl);
   //Initialize AppBlocObserver
  Bloc.observer = AppBlocObserver();
 //  Initialize dependency injection
 // await setupLocator();
  // Run the app
   runApp( MyApp(appRouter: appRouter));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Real Estate',
          debugShowCheckedModeBanner: false,

          onGenerateRoute: appRouter.generateRoute,
          initialRoute: '/splash',
          // ------------------

        );
      },
    );
  }
}