import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

class DetailPageController extends GetxController {
  List<String> exTitles = [];
  List<String> exSubTitles = [];
  List<String> exAuthor = [];
  List<String> exSource = [];
  List<String> exDate = [];
  List<String> exExtractedImage = [];
  List<String> exContent = [];
  bool isLoadCS = true;
  final String link;
  bool isSaved = false;
  User user = FirebaseAuth.instance.currentUser!;

  DetailPageController(this.link);

  @override
  void onInit() {
    super.onInit();
    isLoadCS = true;
    update();
    getDetail(link);
    checkIfSaved();
  }


  getDetail(String u) async {
    try {
      final url = Uri.parse(u);

      final response = await http.get(url);

      if (response.statusCode == 200) {
        try {
          dom.Document document = parser.parse(response.body);
          List<String> titles = document
              .querySelectorAll('#block-mit-page-title')
              .map((element) => element.text.trim())
              .toList();
          List<String> subTitles = document
              .querySelectorAll('.news-article--dek')
              .map((element) => element.text.trim())
              .toList();
          List<String> author = document
              .querySelectorAll('.news-article--author')
              .map((element) => element.text.trim())
              .toList();
          List<String> source = document
              .querySelectorAll('.news-article--source')
              .map((element) => element.text.trim())
              .toList();
          List<String> date = document
              .querySelectorAll('.news-article--publication-date time')
              .map((element) => element.text.trim())
              .toList();
          List<dom.Element> imageElements = document
              .querySelectorAll('.news-article--media--image--file img');
          List<String> extractedImage = imageElements
              .map((element) => element.attributes['data-src'] ?? '')
              .toList();
          List<String> content = document
              .querySelectorAll('.news-article--content--body--inner')
              .map((element) => element.text.trim())
              .toList();

          if (titles.isEmpty) {
            exTitles = [" "];
          } else {
            exTitles = titles;
          }
          if (subTitles.isEmpty) {
            exSubTitles = [" "];
          } else {
            exSubTitles = subTitles;
          }
          if (author.isEmpty) {
            exAuthor = [" "];
          } else {
            exAuthor = author;
          }
          if (source.isEmpty) {
            exSource = [" "];
          } else {
            exSource = source;
          }
          if (date.isEmpty) {
            exDate = [" "];
          } else {
            exDate = date;
          }
          if (extractedImage.isEmpty) {
            exExtractedImage = [" "];
          } else {
            exExtractedImage = extractedImage;
          }
          if (content.isEmpty) {
            exContent = [" "];
          } else {
            exContent = content;
          }
          isLoadCS = false;
          update();
        } catch (e) {
          print(e);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveNews() async {
    try {
      await FirebaseFirestore.instance
          .collection('saved-news')
          .doc(user.uid)
          .collection('articles')
          .add({
        'title': exTitles[0],
        'subtitle': exSubTitles[0],
        'date': exDate[0],
        'source':exSource[0],
        'image': 'https://news.mit.edu${exExtractedImage[0]}',
        'url': link,
        'savedAt': FieldValue.serverTimestamp(),
      });
      isSaved = true;
      update();
    } catch (e) {
      print(e);
    }
  }

  Future<void> checkIfSaved() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('saved-news')
          .doc(user.uid)
          .collection('articles')
          .where('url', isEqualTo: link)
          .limit(1)
          .get();

      isSaved = snapshot.docs.isNotEmpty;
      update();
    } catch (e) {
      print(e);
    }
  }
}
