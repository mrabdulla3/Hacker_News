import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hacker_news/constants/app_colors.dart';
import 'package:hacker_news/controllers/home_controller.dart';
import 'package:hacker_news/controllers/saved_controller.dart';
import 'package:hacker_news/core/routing/app_pages.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Articles'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: GetBuilder<SavedController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(
                child: SpinKitCircle(
              size: 50,
              color: AppColors.secondryColor,
            ));
          } else if (controller.savedArticles.isEmpty) {
            return const Center(child: Text("No saved articles yet"));
          } else {
            return ListView.builder(
              itemCount: controller.savedArticles.length,
              itemBuilder: (context, index) {
                final article = controller.savedArticles[index];
                return GestureDetector(
                  onTap: () => Get.toNamed(Routes.DETAIL_PAGE,
                      arguments: article['url']),
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: article['image'] != null &&
                                    article['image'].isNotEmpty
                                ? Image.network(
                                    article['image'],
                                    fit: BoxFit.cover,
                                    height: 110,
                                    width: 100,
                                  )
                                : Container(
                                    height: 110,
                                    width: 100,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.image_not_supported,
                                        size: 40),
                                  ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 11, left: 10, right: 10, bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article['title'] ?? '',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    article['source'] ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    article['date'] ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline,
                                color: Colors.red),
                            onPressed: () {
                              // Implement delete from saved list
                              controller.deleteArticle(article['id']);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: GetBuilder<HomeController>(
        builder: (controller) => CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: AppColors.secondryColor,
          animationDuration: const Duration(milliseconds: 300),
          height: 70,
          index: controller.selectedIndex,
          items: [
            buildNavItem(
                'assets/wishlist.png', 'Saved', controller.selectedIndex == 0),
            buildNavItem(
                'assets/bot.png', 'Ask AI', controller.selectedIndex == 1),
            buildNavItem(
                'assets/home.png', 'Home', controller.selectedIndex == 2),
            buildNavItem(
                'assets/user.png', 'Profile', controller.selectedIndex == 3),
            buildNavItem('assets/setting.png', 'Settings',
                controller.selectedIndex == 4),
          ],
          onTap: (index) => controller.changePage(index),
        ),
      ),
    );
  }
}

Widget buildNavItem(String icon, String label, bool isSelected) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          height: 24,
          width: 24,
          color: isSelected ? Colors.white : Colors.black,
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 10,
          ),
        ),
      ],
    ),
  );
}
