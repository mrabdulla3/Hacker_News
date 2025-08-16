import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hacker_news/constants/app_colors.dart';
import 'package:hacker_news/controllers/detail_page_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.link});
  final String link;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DetailPageController>(
        builder: (controller) {
          if (controller.isLoadCS) {
            return  const Center(
              child: SpinKitCircle(size: 50, color: AppColors.secondryColor),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
                Text(
                  controller.exTitles.isNotEmpty ? controller.exTitles[0] : '',
                  style: GoogleFonts.abrilFatface(fontSize: 26),
                ),
                const SizedBox(height: 5),
                Text(
                  controller.exAuthor.isNotEmpty ? controller.exAuthor[0] : '',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  controller.exSource.isNotEmpty ? controller.exSource[0] : '',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Text(
                      controller.exDate.isNotEmpty ? controller.exDate[0] : '',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          controller.saveNews();
                        },
                        icon: controller.isSaved
                            ?const Icon(Icons.bookmark,color: Color.fromARGB(255, 255, 89, 0),)
                            :const Icon(Icons.bookmark_border))
                  ],
                ),
                const Divider(),
                Text(
                  controller.exSubTitles.isNotEmpty
                      ? controller.exSubTitles[0]
                      : '',
                  style: GoogleFonts.abyssinicaSil(fontSize: 18),
                ),
                const SizedBox(height: 10),
                if (controller.exExtractedImage.isNotEmpty &&
                    controller.exExtractedImage[0].isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      'https://news.mit.edu${controller.exExtractedImage[0]}',
                      errorBuilder: (context, error, stackTrace) =>
                          const Text("Image not available"),
                    ),
                  ),
                const SizedBox(height: 15),
                Text(
                  controller.exContent.isNotEmpty
                      ? controller.exContent[0]
                      : '',
                  style: GoogleFonts.abel(fontSize: 22),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
