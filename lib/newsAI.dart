import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:flutter_easyloading/flutter_easyloading.dart';

List<String> ExtractedAITitles = [];
List<String> ExtractedAISubtitles = [];
List<String> ExtractedAIDate = [];
List<String> ExtractedAIImage = [];
List<String> ExtractedAILink = [];

Future<void> getWebsiteAIData() async {
  EasyLoading.show(status: '');

  final url = Uri.parse('https://news.mit.edu/topic/artificial-intelligence2');

  final response = await http.get(url);
  print(response);
  if (response.statusCode == 200) {
    dom.Document document = parser.parse(response.body);

    ExtractedAITitles = document
        .querySelectorAll('.term-page--news-article--item--title')
        .map((element) => element.text.trim())
        .toList();
    ExtractedAISubtitles = document
        .querySelectorAll('.term-page--news-article--item--dek')
        .map((element) => element.text.trim())
        .toList();
    ExtractedAIDate = document
        .querySelectorAll('.term-page--news-article--item--publication-date')
        .map((element) => element.text.trim())
        .toList();
    List<dom.Element> imageElements = document
        .querySelectorAll('.term-page--news-article--item--cover-image img');
    ExtractedAIImage = imageElements
        .map((element) => element.attributes['data-src'] ?? '')
        .toList();

    List<dom.Element> linkElement =
        document.querySelectorAll('.term-page--news-article--item--title a');

    linkElement.forEach((element) {
      if (element.attributes.containsKey('href')) {
        String link = element.attributes['href']!;
        ExtractedAILink.add(link);
      }
    });

    print(ExtractedAIDate[0]);
    EasyLoading.dismiss();
  } else {
    throw Exception('Failed Data Loading!');
  }
}
