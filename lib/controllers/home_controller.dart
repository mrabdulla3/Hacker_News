import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hacker_news/views/home.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final GlobalKey<HomeState> myWidgetKey = GlobalKey();
  bool showAllItem = true;
  bool showAiItem = false;
  bool showDSItem = false;
  bool showCSItem = false;
  double currentPage = 0;

  String selectedCategory = 'All';

  @override
  void onInit() {
    super.onInit();
    getWebsiteData();
  }

  void selectCategory(String category) async {
    selectedCategory = category;

    // Reset your showAllItem, showAiItem, etc. accordingly
    showAllItem = false;
    showCSItem = false;
    showDSItem = false;
    showAiItem = false;

    switch (category) {
      case 'All':
        showAllItem = true;
        break;
      case 'Artificial Intelligence':
        showAiItem = true;
        await getWebsiteAIData();
        await setAIdata();
        break;
      case 'Cyber Security':
        showCSItem = true;
        if (await getWebsiteCSData()) {
          await setCSdata();
        }
        break;
    }
    update();
  }

  final PageController pageController = PageController();
  void onPageChanged(double index) {
    currentPage = index;
    update();
  }

  bool isLoading = true;
  bool isLoad = true;
  bool isLoad1 = true;
  List<String> ExtractedTitles = [];
  List<String> ExtractedSubtitles = [];
  List<String> ExtractedDate = [];
  List<String> ExtractedImage = [];

  List<Map<String, String>> showAll = [];
  List<Map<String, String>> showAI = [];
  List<Map<String, String>> showCS = [];

  Future<void> getWebsiteData() async {
    try {
      final url = Uri.parse('https://news.mit.edu/topic/computers');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        dom.Document document = parser.parse(response.body);

        List<String> titles = document
            .querySelectorAll('.term-page--news-article--item--title')
            .map((element) => element.text.trim())
            .toList();
        List<String> subtitles = document
            .querySelectorAll('.term-page--news-article--item--dek')
            .map((element) => element.text.trim())
            .toList();
        List<String> date = document
            .querySelectorAll(
                '.term-page--news-article--item--publication-date')
            .map((element) => element.text.trim())
            .toList();
        List<dom.Element> imageElements = document.querySelectorAll(
            '.term-page--news-article--item--cover-image img');
        List<String> image = imageElements
            .map((element) => element.attributes['data-src'] ?? '')
            .toList();

        List<dom.Element> linkElement = document
            .querySelectorAll('.term-page--news-article--item--title a');
        List<String> links = [];

        for (int i = 0; i < linkElement.length; i++) {
          var element = linkElement[i];
          if (element.attributes.containsKey('href')) {
            String link = element.attributes['href']!;
            links.add(link);
          }
        }

        titles.asMap().forEach((index, title) {
          showAll.add({
            'title': title,
            'subtitle': subtitles[index],
            'date': date[index],
            'image': 'https://news.mit.edu/${image[index]}',
            'link': 'https://news.mit.edu/${links[index]}',
          });
        });

        isLoad1 = false;
        update();
      } else {
        throw Exception('Failed Data Loading!');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> setAIdata() async {
    ExtractedAITitles.asMap().forEach((index, title) {
      showAI.add({
        'title': title,
        'subtitle': ExtractedAISubtitles[index],
        'date': ExtractedAIDate[index],
        'image': 'https://news.mit.edu/' + ExtractedAIImage[index],
        'link': 'https://news.mit.edu/' + ExtractedAILink[index]
      });
    });
    update();
  }

  Future<void> setCSdata() async {
    ExtractedCSTitles.asMap().forEach((index, title) {
      showCS.add({
        'title': title,
        'subtitle': ExtractedCSSubtitles[index],
        'date': ExtractedCSDate[index],
        'image': 'https://news.mit.edu/' + ExtractedCSImage[index],
        'link': 'https://news.mit.edu/' + ExtractedCSLink[index]
      });
    });
    update();
  }

  // AI Data Fetching

  List<String> ExtractedAITitles = [];
  List<String> ExtractedAISubtitles = [];
  List<String> ExtractedAIDate = [];
  List<String> ExtractedAIImage = [];
  List<String> ExtractedAILink = [];

  Future<void> getWebsiteAIData() async {
    EasyLoading.show(status: '');

    final url =
        Uri.parse('https://news.mit.edu/topic/artificial-intelligence2');

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

  // Cyber Security Data Fetching

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
}
