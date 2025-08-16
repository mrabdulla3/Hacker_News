import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hacker_news/common_widgets/custom_bottom_navbar.dart';
import 'package:hacker_news/constants/app_colors.dart';

class AIBot extends StatelessWidget {
  const AIBot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(onPressed: (){Get.back();}, icon:const Icon(Icons.arrow_back_ios_new_rounded)),),
      backgroundColor: AppColors.appTheme,
      body:const Center(
        child: Text('This Feature will be Available Soon...'),
      ),
      bottomNavigationBar:const CustomBottomNavbar(),
    );
  }
}