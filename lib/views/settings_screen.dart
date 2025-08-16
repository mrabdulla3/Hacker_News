import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hacker_news/common_widgets/custom_bottom_navbar.dart';
import 'package:hacker_news/constants/app_colors.dart';
import 'package:hacker_news/controllers/settings_controller.dart';
import 'package:hacker_news/core/routing/app_pages.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appTheme,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        title: const Text('Settings'),
        backgroundColor: AppColors.appBarTheme,
        centerTitle: true,
      ),
      body: GetBuilder<SettingsController>(
        builder: (controller) => ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const Text('General',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SwitchListTile(
              activeColor: AppColors.secondryColor,
              value: true,
              onChanged: (val) {},
              title: const Text('Breaking News Notifications'),
              secondary: const Icon(Icons.notifications),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to language screen
              },
            ),
            const SizedBox(height: 20),
            const Text('Display',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SwitchListTile(
              activeColor: AppColors.secondryColor,
              value: controller.isDark,
              onChanged: (val) {
                controller.toggleTheme();
              },
              title: const Text('Dark Mode'),
              secondary: const Icon(Icons.dark_mode),
            ),
            ListTile(
              leading: const Icon(Icons.format_size),
              title: const Text('Font Size'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Show font size options
              },
            ),
            const SizedBox(height: 20),
            const Text('Account',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Manage Profile'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text('Saved Articles'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Get.toNamed(Routes.SAVED);
              },
            ),
            const SizedBox(height: 20),
            const Text('Others',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: const Text('Terms and Privacy Policy'),
              onTap: () {
                Get.toNamed(Routes.TERMS_AND_CONDITIONS);
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help & Feedback'),
              onTap: () {
                Get.toNamed(Routes.FEEDBACK);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Log Out', style: TextStyle(color: Colors.red)),
              onTap: () {
                // Handle logout
                controller.logOut();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar:const CustomBottomNavbar(),
    );
  }
}

