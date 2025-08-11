import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hacker_news/controllers/home_controller.dart';
import 'package:hacker_news/controllers/profile_controller.dart';
import 'package:hacker_news/core/routing/app_pages.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: const Color.fromARGB(213, 249, 92, 53),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header
            Container(
              padding: const EdgeInsets.all(20),
              color: const Color.fromARGB(213, 249, 92, 53),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/hackerNews.jpg'),
                  ),
                  const SizedBox(width: 20),
                  GetBuilder<ProfileController>(
                    builder: (controller) => controller.isLoding
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.name,
                                style:const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                             const SizedBox(height: 5),
                              Text(
                                controller.email,
                                style:const TextStyle(
                                    color: Colors.white70, fontSize: 14),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),

            // Profile actions
            const SizedBox(height: 20),
            _buildProfileOption(
              icon: Icons.edit,
              title: 'Edit Profile',
              onTap: () {
                // Navigate to edit profile
              },
            ),
            _buildProfileOption(
              icon: Icons.bookmark,
              title: 'Bookmarked Articles',
              onTap: () {
                // Navigate to bookmarked news
                Get.toNamed(Routes.SAVED);
                
              },
            ),
            _buildProfileOption(
              icon: Icons.settings,
              title: 'App Settings',
              onTap: () {
                // Navigate to settings screen
                Get.toNamed(Routes.SETTINGS);
              },
            ),
            _buildProfileOption(
              icon: Icons.logout,
              title: 'Logout',
              onTap: () async {
                // Handle logout
                await FirebaseAuth.instance.signOut();
                Get.offAllNamed(Routes.LOGIN);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: GetBuilder<HomeController>(
        builder: (controller) => CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: const Color(0xFF1779A9),
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

  Widget _buildProfileOption(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue.shade700),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
