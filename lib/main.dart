import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hacker_news/core/routing/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      initialRoute: isLogedIn ? Routes.ONBOARDING : Routes.LOGIN,
      getPages: AppPages.routes,
    );
  }
}
