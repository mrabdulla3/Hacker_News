import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hacker_news/core/routing/app_pages.dart';
import 'package:lottie/lottie.dart';
import 'package:hacker_news/controllers/onboarding_controller.dart';
import 'package:hacker_news/views/home.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingController>(
      builder: (controller) {
        if (controller.seenOnboarding) {
          return const Home();
        }

        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(45),
              child: Lottie.asset(
                'assets/onboarding.json',
                onLoaded: (composition) {
                  // Wait for animation then navigate
                  Future.delayed(composition.duration, () {
                    controller.markSeen(); // mark as seen
                    Get.offAllNamed(Routes.HOME);
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
