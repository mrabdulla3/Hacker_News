import 'package:get/get.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

class DetailPageController extends GetxController {
  List<String> ExTitles = [];
  List<String> ExSubTitles = [];
  List<String> ExAuthor = [];
  List<String> ExSource = [];
  List<String> ExDate = [];
  List<String> ExextractedImage = [];
  List<String> Excontent = [];
  bool isLoadCS = true;
  final String link; 

  DetailPageController(this.link);

  @override
  void onInit() {
    super.onInit();
    print("Links in page: $link");
    isLoadCS = true;
    update();
    getDetail(link);
  }

  getDetail(String u) async {
    try {
      final url = Uri.parse(u);

      final response = await http.get(url);

      if (response.statusCode == 200) {
        try {
          dom.Document document = parser.parse(response.body);
          List<String> Titles = document
              .querySelectorAll('#block-mit-page-title')
              .map((element) => element.text.trim())
              .toList();
          List<String> SubTitles = document
              .querySelectorAll('.news-article--dek')
              .map((element) => element.text.trim())
              .toList();
          List<String> Author = document
              .querySelectorAll('.news-article--author')
              .map((element) => element.text.trim())
              .toList();
          List<String> Source = document
              .querySelectorAll('.news-article--source')
              .map((element) => element.text.trim())
              .toList();
          List<String> Date = document
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

          if (Titles.isEmpty) {
            ExTitles = [" "];
          } else {
            ExTitles = Titles;
          }
          if (SubTitles.isEmpty) {
            ExSubTitles = [" "];
          } else {
            ExSubTitles = SubTitles;
          }
          if (Author.isEmpty) {
            print("Author");
            ExAuthor = [" "];
          } else {
            ExAuthor = Author;
          }
          if (Source.isEmpty) {
            ExSource = [" "];
          } else {
            ExSource = Source;
          }
          if (Date.isEmpty) {
            ExDate = [" "];
          } else {
            ExDate = Date;
          }
          if (extractedImage.isEmpty) {
            ExextractedImage = [" "];
          } else {
            ExextractedImage = extractedImage;
          }
          if (content.isEmpty) {
            Excontent = [" "];
          } else {
            Excontent = content;
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
}
