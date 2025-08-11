import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:hacker_news/controllers/home_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text('General', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SwitchListTile(
            value: true,
            onChanged: (val) {},
            title: const Text('Breaking News Notifications'),
            secondary: const Icon(Icons.notifications),
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('News Categories'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to category screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to language screen
            },
          ),
          SwitchListTile(
            value: true,
            onChanged: (val) {},
            title: const Text('Local News Based on Location'),
            secondary: const Icon(Icons.location_on),
          ),

          const SizedBox(height: 20),
          const Text('Display', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SwitchListTile(
            value: false,
            onChanged: (val) {},
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
          SwitchListTile(
            value: true,
            onChanged: (val) {},
            title: const Text('Load Images'),
            secondary: const Icon(Icons.image),
          ),

          const SizedBox(height: 20),
          const Text('Account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
            onTap: () {},
          ),

          const SizedBox(height: 20),
          const Text('Others', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Terms and Privacy Policy'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help & Feedback'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Log Out', style: TextStyle(color: Colors.red)),
            onTap: () {
              // Handle logout
            },
          ),
        ],
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