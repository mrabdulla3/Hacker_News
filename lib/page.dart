import 'package:flutter/material.dart';
import 'main.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class page extends StatefulWidget {
  page({Key? key, required this.link}) : super(key: key);
  final String link;
  @override
  State<page> createState() => pageState();
}

List<String> ExTitles = [];
List<String> ExSubTitles = [];
List<String> ExAuthor = [];
List<String> ExSource = [];
List<String> ExDate = [];
List<String> ExextractedImage = [];
List<String> Excontent = [];
bool isLoadCS = true;

class pageState extends State<page> {
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

          setState(() {
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
          });
        } catch (e) {
          print(e);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    print("Links in page");
    print(widget.link);
    setState(() {
      isLoadCS = true;
    });

    getDetail(widget.link);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 50, left: 10, right: 10, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MyHomePage(title: 'Hacker News'),
                            ));
                      },
                      icon: Icon(Icons.arrow_back_rounded)),
                  Text(
                    ExTitles[0] ?? '',
                    style: GoogleFonts.abrilFatface(
                      textStyle: TextStyle(fontSize: 26, letterSpacing: .5),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(ExAuthor[0] ?? '',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(ExSource[0] ?? '',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(ExDate[0] ?? '',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                  Divider(),
                  Text(
                    ExSubTitles[0] ?? '',
                    style: GoogleFonts.abyssinicaSil(
                      textStyle: TextStyle(fontSize: 18, letterSpacing: .5),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      child: Image.network(
                          'https://news.mit.edu' + ExextractedImage[0])),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    Excontent[0] ?? '',
                    style: GoogleFonts.abel(
                      textStyle: TextStyle(fontSize: 22, letterSpacing: .5),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isLoadCS)
            Center(
              child: SpinKitCircle(
                size: 50,
                color: Colors.blue,
              ),
            ),
        ],
      ),
    );
  }
}
