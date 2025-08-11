import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hacker_news/core/routing/app_pages.dart';

class SidebarController extends GetxController {
  bool isLoding = false;
  String name = "";
  String email = "";
  @override
  void onInit() {
    super.onInit();
    getDetails();
  }

  Future<void> getDetails() async {
    isLoding = true;
    update();
    try {
      User? user = FirebaseAuth.instance.currentUser;
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      if (doc.exists) {
        name = doc['username'] ?? "No Name";
      }
      if (user != null) {
        email = user.email ?? "No Email";
      }
    } catch (e) {
      print(e);
    } finally {
      isLoding = false;
      update();
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
