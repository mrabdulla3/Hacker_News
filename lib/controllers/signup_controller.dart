import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hacker_news/core/routing/app_pages.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  bool isChecked = false;
  bool passwordVisible = true;
  bool confPasswordVisible = true;

  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  void passwordTogle(bool password) {
    passwordVisible = !password;
    update();
  }

  void confPasswordTogle(bool password) {
    confPasswordVisible = !password;
    update();
  }

  Future<void> register() async {
    isLoading = true;
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: mailController.text.trim(),
              password: passwordController.text.trim());

      String uid = user.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'username': nameController.text.trim(),
        'email': mailController.text.trim(),
        'password': passwordController.text.trim()
      });
      Get.snackbar("Success", "Registered Successfully");
      Get.toNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Warning", "Password Provided is too Weak");
      } else if (e.code == "email-already-in-use") {
        Get.snackbar("Warning", "Account Already exists");
      } else {
        Get.snackbar("", "Check your internet connection!");
      }
    } finally {
      isLoading = false;
    }
  }
}
