import 'package:get/get.dart';

class OnboardingController extends GetxController {
  bool seenOnboarding = false;

  void markSeen() {
    seenOnboarding = true;
    update();
  }
}
