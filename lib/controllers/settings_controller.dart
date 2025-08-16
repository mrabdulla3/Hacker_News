import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hacker_news/core/routing/app_pages.dart';

class SettingsController extends GetxController{
  bool isDark=false;

  void toggleTheme() {
    isDark = !isDark;
    update();
  }
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}