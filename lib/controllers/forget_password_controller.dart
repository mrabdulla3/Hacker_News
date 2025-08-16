import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool get isEmailValid => emailController.text.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(() {
      update(); // rebuild UI when text changes
    });
  }

  void forgetPassword() {
    if (formKey.currentState!.validate()) {
      Get.snackbar("Success", "Password reset email sent to ${emailController.text}");
    }
    emailController.clear();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
