import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'page.dart';
import 'newsAI.dart';
import 'newsCS.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'NavBar.dart';
import 'Onboarding.dart';

void main() {
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.blue
    ..indicatorColor = Colors.blue
    ..textColor = Colors.white
    ..backgroundColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false
    ..indicatorType = EasyLoadingIndicatorType.circle;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(),
        useMaterial3: true,
      ),
      home: const onboarding(),
      builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<_MyHomePageState> myWidgetKey = GlobalKey();
  Color colorAllButton = Colors.white;
  Color colorDSButton = Colors.white;
  Color colorAIButton = Colors.white;
  Color colorCSButton = Colors.white;


  @override
  void initState() {
    super.initState();

    colorAllButton = Colors.deepPurpleAccent.shade100;
    getWebsiteData();
  }

  Color buttonTextColor = Colors.black;

  bool showAllItem = true;
  bool showAiItem = false;
  bool showDSItem = false;
  bool showCSItem = false;

  int _currentPage = 0;

  final PageController _pageController = PageController();
  void onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
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

        setState(() {
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
        });
      } else {
        throw Exception('Failed Data Loading!');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> setAIdata() async {
    setState(() {
      ExtractedAITitles.asMap().forEach((index, title) {
        showAI.add({
          'title': title,
          'subtitle': ExtractedAISubtitles[index],
          'date': ExtractedAIDate[index],
          'image': 'https://news.mit.edu/' + ExtractedAIImage[index],
          'link': 'https://news.mit.edu/' + ExtractedAILink[index]
        });
      });
      print("1");
      print(showAI[0]['image']);
    });
  }

  Future<void> setCSdata() async {
    setState(() {
      ExtractedCSTitles.asMap().forEach((index, title) {
        showCS.add({
          'title': title,
          'subtitle': ExtractedCSSubtitles[index],
          'date': ExtractedCSDate[index],
          'image': 'https://news.mit.edu/' + ExtractedCSImage[index],
          'link': 'https://news.mit.edu/' + ExtractedCSLink[index]
        });
      });
      print("1");
      print(showCS[0]['link']);
      print(showCS[1]['link']);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Container(
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(13),
                      bottomLeft: Radius.circular(13))),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400),
                ),
              )),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.search_outlined)),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.notifications)),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 17,
                top: 3,
              ),
              child: Text(
                'Breaking News',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
                child: SizedBox(
                    height: screenHeight * 0.3,
                    width: screenWidth,
                    child: isLoad1
                        ? const SpinKitCircle(
                            size: 50,
                            color: Colors.blue,
                          )
                        : PageView.builder(
                            controller: _pageController,
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(13),
                                    child: Image.network(
                                      showAll[index]['image']!,
                                      fit: BoxFit.cover,
                                      width: screenWidth,
                                      height: screenHeight * 0.3,
                                    ),
                                  ),
                                  Positioned(
                                      left: 10,
                                      top: 10,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => page(
                                                      link: showAll[index]
                                                          ['link']!)));
                                        },
                                        child: const Text(
                                          'Click',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 12),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.4),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(13),
                                            bottomRight: Radius.circular(13),
                                          ),
                                        ),
                                        child:
                                            /*isLoad1?SpinKitCircle(
                                    size: 50,color: Colors.blue,
                                  ): */

                                            LayoutBuilder(builder:
                                                (context, constraints) {
                                          return Text(
                                            showAll[index]['title']!,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: constraints.maxWidth *
                                                  0.045, // Adjust the multiplier as needed
                                              fontWeight: FontWeight.w400,
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          );
                                        })),
                                  )
                                ]),
                              );
                            },
                            onPageChanged: onPageChanged,
                          ))),
            Center(
              child: DotsIndicator(
                dotsCount: 4,
                position: _currentPage,
                decorator: DotsDecorator(
                    activeColor: Colors.deepPurpleAccent.shade100,
                    size: const Size.square(10.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showAllItem = true;
                              showCSItem = false;
                              showDSItem = false;
                              showAiItem = false;

                              colorAllButton = Colors.deepPurpleAccent.shade100;
                              colorCSButton = Colors.white;
                              colorDSButton = Colors.white;
                              colorAIButton = Colors.white;
                            });
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  colorAllButton)),
                          child: Text(
                            'All',
                            style: TextStyle(color: buttonTextColor),
                          )),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() async {
                              showAllItem = false;
                              showCSItem = false;
                              showDSItem = false;
                              showAiItem = true;
                              colorAIButton = Colors.deepPurpleAccent.shade100;
                              colorCSButton = Colors.white;
                              colorDSButton = Colors.white;
                              colorAllButton = Colors.white;
                              await getWebsiteAIData();
                              await setAIdata();
                            });
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  colorAIButton)),
                          child: Text('Artificial Intelligency',
                              style: TextStyle(color: buttonTextColor))),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() async {
                              showAllItem = false;
                              showCSItem = true;
                              showDSItem = false;
                              showAiItem = false;
                              colorCSButton = Colors.deepPurpleAccent.shade100;
                              colorDSButton = Colors.white;
                              colorAIButton = Colors.white;
                              colorAllButton = Colors.white;
                              if (await getWebsiteCSData()) {
                                await setCSdata();
                              }
                            });
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  colorCSButton)),
                          child: Text('Cyber Security',
                              style: TextStyle(color: buttonTextColor))),
                    )
                  ],
                )),
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Recommendation',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
                child: Container(
              height: screenHeight * 0.4,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0)),
                  color: Colors.grey.shade200),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: isLoad1
                      ? const SpinKitCircle(
                          size: 50,
                          color: Colors.blue,
                        )
                      : ListView.builder(
                          itemExtent: 150,
                          itemCount: showAllItem
                              ? showAll.length
                              : (showAiItem
                                  ? showAI.length
                                  : (showCSItem ? showCS.length! : 0)),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => page(
                                            link: showAllItem
                                                ? showAll[index]['link']!
                                                : (showAiItem
                                                    ? showAI[index]['link']!
                                                    : (showCSItem
                                                        ? showCS[index]['link']!
                                                        : '')))));
                              },
                              child: Card(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.network(
                                        showAllItem
                                            ? showAll[index]['image']!
                                            : (showAiItem
                                                ? showAI[index]['image']!
                                                : (showCSItem
                                                    ? showCS[index]['image']!
                                                    : '')),
                                        fit: BoxFit.cover,
                                        height: 110,
                                        width: 100,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 11, left: 10, right: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                showAllItem
                                                    ? showAll[index]['title']!
                                                    : (showAiItem
                                                        ? showAI[index]
                                                            ['title']!
                                                        : (showCSItem
                                                            ? showCS[index]
                                                                ['title']!
                                                            : '')),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14)),
                                            Text(
                                                showAllItem
                                                    ? showAll[index]
                                                        ['subtitle']!
                                                    : (showAiItem
                                                        ? showAI[index]
                                                            ['subtitle']!
                                                        : (showCSItem
                                                            ? showCS[index]
                                                                ['subtitle']!
                                                            : '')),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 13)),
                                            Text(
                                                showAllItem
                                                    ? showAll[index]['date']!
                                                    : (showAiItem
                                                        ? showAI[index]['date']!
                                                        : (showCSItem
                                                            ? showCS[index]
                                                                ['date']!
                                                            : '')),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 13))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                            );
                          },
                        )),
            ))
          ],
        ));
  }
}
