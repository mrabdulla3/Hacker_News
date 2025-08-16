import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hacker_news/constants/app_colors.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        title: const Text("Terms & Conditions"),
        centerTitle: true,
        backgroundColor: AppColors.secondryColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome to Our App",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "These Terms and Conditions outline the rules and regulations for the use of our application.\n\n"
                        "1. By accessing this app, we assume you accept these terms in full.\n"
                        "2. You must not use this app in any way that causes damage or affects availability.\n"
                        "3. All intellectual property rights are reserved.\n"
                        "4. We may revise these terms at any time without prior notice.\n"
                        "5. Your continued use of the app will signify your acceptance of any adjustments.\n\n"
                        "This is only a dummy placeholder text for demonstration purposes.",
                        style: TextStyle(fontSize: 16, height: 1.5),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Please read these terms carefully before proceeding.",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text("I Accept", style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
