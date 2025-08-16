import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FeedbackController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final mailController = TextEditingController();
  final messageController = TextEditingController();
  double rating = 0.0; 

  Future<void> sendFeedback() async {
    final  link=dotenv.env['FEEDBACK_URL'];
    if (!formKey.currentState!.validate()) return;

    final url = Uri.parse(link!);

    final payload = {
      "email": mailController.text,
      "feedback": messageController.text,
      "rating": rating, 
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200 || response.statusCode==302) {
        Get.snackbar("Success", "Feedback sent successfully!");
        mailController.clear();
        messageController.clear();
        rating = 0.0; 
        update();
      } else{
        Get.snackbar("Error", "Something went wrong");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    }
  }
}
