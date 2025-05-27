import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:hacker_news/controllers/home_controller.dart';
import 'package:hacker_news/core/routing/app_pages.dart';
import 'package:hacker_news/views/detail_page.dart';
import 'package:hacker_news/views/sidebar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dots_indicator/dots_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        drawer: const Sidebar(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Container(
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(13),
                      bottomLeft: Radius.circular(13))),
              child:const Padding(
                padding:  EdgeInsets.all(3.0),
                child: Text(
                  'Hacker News',
                  style:  TextStyle(
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
        body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) => Column(
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
                  padding: const EdgeInsets.only(
                      top: 0, bottom: 0, left: 8, right: 8),
                  child: SizedBox(
                      height: screenHeight * 0.3,
                      width: screenWidth,
                      child: controller.isLoad1
                          ? const SpinKitCircle(
                              size: 50,
                              color: Colors.blue,
                            )
                          : PageView.builder(
                              controller: controller.pageController,
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(13),
                                      child: Image.network(
                                        controller.showAll[index]['image']!,
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
                                                    builder: (context) =>
                                                        DetailPage(
                                                            link: controller
                                                                        .showAll[
                                                                    index]
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
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(13),
                                              bottomRight: Radius.circular(13),
                                            ),
                                          ),
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            return Text(
                                              controller.showAll[index]
                                                  ['title']!,
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
                              onPageChanged: (int value) =>
                                  controller.onPageChanged(value.toDouble()),
                            ))),
              Center(
                child: DotsIndicator(
                  dotsCount: 4,
                  position: controller.currentPage,
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
                    const SizedBox(width: 5),
                    categoryButton('All'),
                    const SizedBox(width: 5),
                    categoryButton('Artificial Intelligence'),
                    const SizedBox(width: 5),
                    categoryButton('Cyber Security')
                  ],
                ),
              ),
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
                    child: controller.isLoad1
                        ? const SpinKitCircle(
                            size: 50,
                            color: Colors.blue,
                          )
                        : ListView.builder(
                            itemExtent: 150,
                            itemCount: controller.showAllItem
                                ? controller.showAll.length
                                : (controller.showAiItem
                                    ? controller.showAI.length
                                    : (controller.showCSItem
                                        ? controller.showCS.length!
                                        : 0)),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  String link = controller.showAllItem
                                      ? controller.showAll[index]['link']!
                                      : (controller.showAiItem
                                          ? controller.showAI[index]['link']!
                                          : (controller.showCSItem
                                              ? controller.showCS[index]
                                                  ['link']!
                                              : ''));

                                  if (link.isNotEmpty) {
                                    Get.toNamed(Routes.DETAIL_PAGE,
                                        arguments: link);
                                  }
                                },
                                child: Card(
                                    child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: Image.network(
                                          controller.showAllItem
                                              ? controller.showAll[index]
                                                  ['image']!
                                              : (controller.showAiItem
                                                  ? controller.showAI[index]
                                                      ['image']!
                                                  : (controller.showCSItem
                                                      ? controller.showCS[index]
                                                          ['image']!
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
                                                  controller.showAllItem
                                                      ? controller.showAll[
                                                          index]['title']!
                                                      : (controller.showAiItem
                                                          ? controller
                                                                  .showAI[index]
                                                              ['title']!
                                                          : (controller
                                                                  .showCSItem
                                                              ? controller
                                                                          .showCS[
                                                                      index]
                                                                  ['title']!
                                                              : '')),
                                                  maxLines: 3,
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14)),
                                              Text(
                                                  controller.showAllItem
                                                      ? controller
                                                              .showAll[index]
                                                          ['subtitle']!
                                                      : (controller.showAiItem
                                                          ? controller
                                                                  .showAI[index]
                                                              ['subtitle']!
                                                          : (controller
                                                                  .showCSItem
                                                              ? controller
                                                                          .showCS[
                                                                      index]
                                                                  ['subtitle']!
                                                              : '')),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 13)),
                                              Text(
                                                  controller.showAllItem
                                                      ? controller
                                                              .showAll[index]
                                                          ['date']!
                                                      : (controller.showAiItem
                                                          ? controller
                                                                  .showAI[index]
                                                              ['date']!
                                                          : (controller
                                                                  .showCSItem
                                                              ? controller
                                                                          .showCS[
                                                                      index]
                                                                  ['date']!
                                                              : '')),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
          ),
        ));
  }
}

Widget categoryButton(String title) {
  return GetBuilder<HomeController>(
    builder: (controller) {
      final bool isSelected = controller.selectedCategory == title;
      return Padding(
        padding: const EdgeInsets.all(2),
        child: ElevatedButton(
          onPressed: () => controller.selectCategory(title),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              isSelected ? Colors.deepPurpleAccent.shade100 : Colors.white,
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      );
    },
  );
}
