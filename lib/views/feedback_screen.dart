import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hacker_news/constants/app_colors.dart';
import 'package:hacker_news/controllers/feedback_controller.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  Widget _buildStar(int index, FeedbackController controller) {
    return IconButton(
      icon: Icon(
        index < controller.rating ? Icons.star : Icons.star_border,
        color: Colors.orangeAccent,
      ),
      onPressed: () {
        controller.rating = index + 1.0;
        controller.update();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        title: const Text('Feedback'),
        centerTitle: true,
        backgroundColor: AppColors.appBarTheme,
      ),
      body: GetBuilder<FeedbackController>(
        init: FeedbackController(),
        builder: (controller) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rate your experience',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: List.generate(
                        5, (index) => _buildStar(index, controller)),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: controller.mailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a comment' : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Leave a comment',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: controller.messageController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Write your feedback here...',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a comment' : null,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: controller.sendFeedback,
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
