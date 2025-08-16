import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hacker_news/core/routing/app_pages.dart';

class LoginController extends GetxController {
  String email = "", password = "";
  bool rememberMe = false;
  bool passwordVisible = true;
  bool isLoading = false;

  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void passwodTogle(bool visible){
      passwordVisible=!visible;
     update();
  }
  Future<void> signin() async {
    isLoading = true;
    update();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: mailController.text.trim(),
          password: passwordController.text.trim());
      Get.toNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("Warning", "No User Found for that Email");
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Warning", "Wrong Password Provided by User");
      } else {
        Get.snackbar("Warning", "Check your internet connection!");
      }
    } finally {
      isLoading = false;
      update();
    }
  }

}
