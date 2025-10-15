import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:work_timer/core/blocs/b_stopwatch.dart';
import 'package:work_timer/core/controller/c_theme.dart';
import 'package:work_timer/core/services/core_services.dart';
import 'package:work_timer/presentation/p_home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async{
  await ScreenUtil.ensureScreenSize();
  await CoreServices.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final cTheme = Get.put(CTheme());

    return ScreenUtilInit(
      designSize: const Size(430, 932), // iPhone X size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) {
        return GetBuilder<CTheme>(
          builder: (cTheme) {
            return AnimatedTheme(
              duration: Duration(microseconds: 500),
              curve: Curves.bounceIn,
              data: cTheme.currentTheme,
              child: BlocProvider(
                create: (context) => CounterBloc(),
                child: GetMaterialApp(
                  theme: cTheme.lightTheme,
                  darkTheme: cTheme.darkTheme,
                  themeMode: ThemeMode.light,
                  home: const PHome()),
              ),
            );
          },
        );
      },
    );
  }
}
