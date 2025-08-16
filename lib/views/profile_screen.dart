import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hacker_news/common_widgets/custom_bottom_navbar.dart';
import 'package:hacker_news/constants/app_colors.dart';
import 'package:hacker_news/controllers/profile_controller.dart';
import 'package:hacker_news/core/routing/app_pages.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        title: const Text('My Profile'),
        centerTitle: true,
        backgroundColor: AppColors.appBarTheme,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header
            Container(
              padding: const EdgeInsets.all(20),
              color: AppColors.appBarTheme,
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/hackerNews.png'),
                  ),
                  const SizedBox(width: 20),
                  GetBuilder<ProfileController>(
                    builder: (controller) => controller.isLoding
                        ? const Center(
                            child: SpinKitCircle(
                              size: 50,
                              color: AppColors.secondryColor,
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.name,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                controller.email,
                                style: const TextStyle(fontSize: 14),
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
              title: 'Saved Articles',
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
      bottomNavigationBar:const CustomBottomNavbar()
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
        leading: Icon(icon, color: AppColors.secondryColor),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
