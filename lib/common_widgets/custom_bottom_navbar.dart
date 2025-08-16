import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:hacker_news/constants/app_colors.dart';
import 'package:hacker_news/controllers/home_controller.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
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
