import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hacker_news/core/routing/app_pages.dart';
import 'views/Onboarding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configLoading();
  runApp(const MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.blue
    ..indicatorColor = Colors.blue
    ..textColor = Colors.white
    ..backgroundColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false
    ..indicatorType = EasyLoadingIndicatorType.circle;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(),
        useMaterial3: true,
      ),
      initialRoute: Routes.HOME, // 👈 Optional: if you want to use named routes
      getPages: AppPages.routes, // 👈 Required for named route navigation
      home: const Onboarding(), // 👈 Optional if using named routes instead
      builder: EasyLoading.init(),
    );
  }
}
