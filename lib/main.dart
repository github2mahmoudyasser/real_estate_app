import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constants/api_constant.dart';
import 'core/constants/bloc_abserver.dart';
import 'core/constants/dio_helper.dart';
import 'feature/splash_screen/ui/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize SharedPreferences
  //await PreferenceManager().init();
   //Initialize ScreenUtil
  await ScreenUtil.ensureScreenSize();
  // Initialize Dio
  DioHelper.init(baseUrl: ApiConstant.baseUrl);
   //Initialize AppBlocObserver
  Bloc.observer = AppBlocObserver();
 //  Initialize dependency injection
 // await setupLocator();
  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
          home: const SplashScreen(),
        );
      },
    );
  }
}
