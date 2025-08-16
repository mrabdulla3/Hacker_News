import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hacker_news/core/routing/app_pages.dart';

class SettingsController extends GetxController{
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}