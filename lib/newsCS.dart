import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:flutter_easyloading/flutter_easyloading.dart';

List<String> ExtractedCSTitles = [];
List<String> ExtractedCSSubtitles = [];
List<String> ExtractedCSDate = [];
List<String> ExtractedCSImage = [];
List<String> ExtractedCSLink = [];

Future<bool> getWebsiteCSData() async {
  EasyLoading.show(status: '');
  final url = Uri.parse('https://news.mit.edu/topic/cyber-security');

  final response = await http.get(url);
  print(response);
  if (response.statusCode == 200) {
    dom.Document document = parser.parse(response.body);

    ExtractedCSTitles = document
        .querySelectorAll('.term-page--news-article--item--title')
        .map((element) => element.text.trim())
        .toList();
    ExtractedCSSubtitles = document
        .querySelectorAll('.term-page--news-article--item--dek')
        .map((element) => element.text.trim())
        .toList();
    ExtractedCSDate = document
        .querySelectorAll('.term-page--news-article--item--publication-date')
        .map((element) => element.text.trim())
        .toList();
    List<dom.Element> imageElements = document
        .querySelectorAll('.term-page--news-article--item--cover-image img');
    ExtractedCSImage = imageElements
        .map((element) => element.attributes['data-src'] ?? '')
        .toList();

    List<dom.Element> linkElement =
        document.querySelectorAll('.term-page--news-article--item--title a');

    linkElement.forEach((element) {
      if (element.attributes.containsKey('href')) {
        String link = element.attributes['href']!;
        ExtractedCSLink.add(link);
      }
    });

    print(ExtractedCSImage[0]);
    EasyLoading.dismiss();
  } else {
    throw Exception('Failed Data Loading!');
  }
  return true;
}
