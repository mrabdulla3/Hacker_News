import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';

class SavedController extends GetxController {
  List<Map<String, dynamic>> savedArticles = [];
  bool isLoading = false;
    @override
  void onInit() {
    super.onInit();
    getSavedArticles();
  }

  Future<void> getSavedArticles() async {
    try {
      isLoading = true;
      update();
      User user = FirebaseAuth.instance.currentUser!;
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('saved-news')
          .doc(user.uid)
          .collection('articles')
          .orderBy('savedAt', descending: true)
          .get();

      savedArticles = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
          print(savedArticles);
    } catch (e) {
      print(e);
    }finally {
      isLoading = false;
      update();
    }
  }
}
