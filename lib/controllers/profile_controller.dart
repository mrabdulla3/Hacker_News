import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  String name = "";
  String email = "";
  bool isLoding = false;
  @override
  void onInit() {
    super.onInit();
    getProfileData();
  }

  Future<void> getProfileData() async {
    isLoding = true;
    update();
    try {
      User user = FirebaseAuth.instance.currentUser!;
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (doc.exists) {
        name = doc['username'];
        email = doc['email'];
      }
    } catch (e) {
      print(e);
    } finally {
      isLoding = false;
      update();
    }
  }
}
