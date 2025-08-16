import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hacker_news/core/routing/app_pages.dart';
import 'package:hacker_news/views/bot_screen.dart';
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
  bool isSearching=false;
  TextEditingController searchController=TextEditingController();

  String selectedCategory = 'All';
  int selectedIndex = 2;

  bool isLoading = true;
  bool isLoad = true;
  bool isLoad1 = true;
  List<String> extractedTitles = [];
  List<String> extractedSubtitles = [];
  List<String> extractedDate = [];
  List<String> extractedImage = [];

  List<Map<String, String>> showAll = [];
  List<Map<String, String>> showAI = [];
  List<Map<String, String>> showCS = [];

  List<Map<String, String>> searchedNews = [];
     bool get isSearchingActive => isSearching && searchController.text.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    getWebsiteData();
  }

  void changePage(int index) {
    selectedIndex = index;
    update();

    switch (index) {
      case 0:
        Get.toNamed(Routes.SAVED);
        break;
      case 1:
        Get.to(const AIBot());
        break;
      case 2:
        Get.toNamed(Routes.HOME);
        break;
      case 3:
        Get.toNamed(Routes.PROFILE);
        break;
      case 4:
        Get.toNamed(Routes.SETTINGS);
        break;
    }
  }

  void selectCategory(String category) async {
    selectedCategory = category;

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
        isLoad = false;
        update();
      } else {
        throw Exception('Failed Data Loading!');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> setAIdata() async {
    extractedTitles.asMap().forEach((index, title) {
      showAI.add({
        'title': title,
        'subtitle': extractedSubtitles[index],
        'date': extractedDate[index],
        'image': 'https://news.mit.edu/${extractedImage[index]}',
        'link': 'https://news.mit.edu/${extractedLink[index]}'
      });
    });
    update();
  }

  Future<void> setCSdata() async {
    extractedTitles.asMap().forEach((index, title) {
      showCS.add({
        'title': title,
        'subtitle': extractedSubtitles[index],
        'date': extractedDate[index],
        'image': 'https://news.mit.edu/${extractedImage[index]}',
        'link': 'https://news.mit.edu/${extractedLink[index]}'
      });
    });
    update();
  }

  // AI Data Fetching

  /*List<String> ExtractedAITitles = [];
  List<String> ExtractedAISubtitles = [];
  List<String> ExtractedAIDate = [];
  List<String> ExtractedAIImage = [];*/
  List<String> extractedLink = [];

  Future<void> getWebsiteAIData() async {
    isLoad = true;
    update();
    final url =
        Uri.parse('https://news.mit.edu/topic/artificial-intelligence2');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      dom.Document document = parser.parse(response.body);

      extractedTitles = document
          .querySelectorAll('.term-page--news-article--item--title')
          .map((element) => element.text.trim())
          .toList();
      extractedSubtitles = document
          .querySelectorAll('.term-page--news-article--item--dek')
          .map((element) => element.text.trim())
          .toList();
      extractedDate = document
          .querySelectorAll('.term-page--news-article--item--publication-date')
          .map((element) => element.text.trim())
          .toList();
      List<dom.Element> imageElements = document
          .querySelectorAll('.term-page--news-article--item--cover-image img');
      extractedImage = imageElements
          .map((element) => element.attributes['data-src'] ?? '')
          .toList();

      List<dom.Element> linkElement =
          document.querySelectorAll('.term-page--news-article--item--title a');

      linkElement.forEach((element) {
        if (element.attributes.containsKey('href')) {
          String link = element.attributes['href']!;
          extractedLink.add(link);
        }
      });
      isLoad = false;
      update();
    } else {
      isLoad = false;
      update();
      throw Exception('Failed Data Loading!');
    }
  }

  // Cyber Security Data Fetching

  /*List<String> ExtractedCSTitles = [];
  List<String> ExtractedCSSubtitles = [];
  List<String> ExtractedCSDate = [];
  List<String> ExtractedCSImage = [];
  List<String> ExtractedCSLink = [];*/

  Future<bool> getWebsiteCSData() async {
    isLoad = true;
    update();
    final url = Uri.parse('https://news.mit.edu/topic/cyber-security');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      dom.Document document = parser.parse(response.body);

      extractedTitles = document
          .querySelectorAll('.term-page--news-article--item--title')
          .map((element) => element.text.trim())
          .toList();
      extractedSubtitles = document
          .querySelectorAll('.term-page--news-article--item--dek')
          .map((element) => element.text.trim())
          .toList();
      extractedDate = document
          .querySelectorAll('.term-page--news-article--item--publication-date')
          .map((element) => element.text.trim())
          .toList();
      List<dom.Element> imageElements = document
          .querySelectorAll('.term-page--news-article--item--cover-image img');
      extractedImage = imageElements
          .map((element) => element.attributes['data-src'] ?? '')
          .toList();

      List<dom.Element> linkElement =
          document.querySelectorAll('.term-page--news-article--item--title a');

      linkElement.forEach((element) {
        if (element.attributes.containsKey('href')) {
          String link = element.attributes['href']!;
          extractedLink.add(link);
        }
      });
      isLoad = false;
      update();
    } else {
      isLoad = false;
      update();
      throw Exception('Failed Data Loading!');
    }
    return true;
  }

  void searchNews(String query) {
    if (query.isEmpty) {
      searchedNews = [];
    } else {
     

      searchedNews = showAll
          .where((item) =>
              item['title']!.toLowerCase().contains(query.toLowerCase()) ||
              item['subtitle']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    print(searchedNews);
    update();
  }

  void clearSearch() {
    searchController.clear();
    searchedNews = [];
    isSearching = false;
    update();
  }
}

