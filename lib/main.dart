import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hacker_news/core/routing/app_pages.dart';
import 'views/Onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configLoading();
  final User? currentUser = FirebaseAuth.instance.currentUser;

  runApp(MyApp(
    isLogedIn: currentUser != null,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLogedIn;
  const MyApp({super.key, required this.isLogedIn});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(),
        useMaterial3: true,
      ),
      initialRoute: isLogedIn ? Routes.HOME : Routes.LOGIN,
      getPages: AppPages.routes,
      home: const Onboarding(),
      builder: EasyLoading.init(),
    );
  }
}
