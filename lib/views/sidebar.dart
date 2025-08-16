import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hacker_news/constants/app_colors.dart';
import 'package:hacker_news/controllers/sidebar_controller.dart';
import 'package:hacker_news/core/routing/app_pages.dart';
import 'package:hacker_news/views/about_us.dart';
import 'package:hacker_news/views/feedback_screen.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height / 2.1;
    return Drawer(
      child: GetBuilder<SidebarController>(
        init: SidebarController(),
        builder: (controller) => ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: screenHeight * 0.8,
              child: controller.isLoding
                  ?const SpinKitCircle(
                              size: 50,
                              color: AppColors.secondryColor,
                            )
                  : DrawerHeader(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/hackerNews.png'),
                          radius: 50,
                        ),
                        Text(
                          controller.name,
                          style: GoogleFonts.abrilFatface(
                            textStyle: const TextStyle(
                                fontSize: 20, letterSpacing: .5),
                          ),
                        ),
                        Text(
                          controller.email,
                          style: GoogleFonts.aBeeZee(
                            textStyle: const TextStyle(
                                fontSize: 20, letterSpacing: .5),
                          ),
                        ),
                      ],
                    )),
            ),
            ListTile(
                leading: const Icon(Icons.feedback_outlined),
                title: const Text('Feedback'),
                onTap: () {
                  Get.to(() => const FeedbackScreen());
                }),
            ListTile(
              leading: const Icon(Icons.account_box_outlined),
              title: const Text('About Us'),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUs(),
                  )),
            ),
            ListTile(
                leading: const Icon(Icons.contact_page_outlined),
                title: const Text('Contact Us'),
                onTap: () {
                  Get.toNamed(Routes.CONTACT);
                }),
            ListTile(
              leading: const Icon(Icons.bookmark_border),
              title: const Text('Saved Articles'),
              onTap: () {
                Get.toNamed(Routes.SAVED);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => {Get.toNamed(Routes.SETTINGS)},
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text(
                'Log Out',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () => {controller.logOut()},
            ),
          ],
        ),
      ),
    );
  }
}
