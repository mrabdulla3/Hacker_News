import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            return const Center(
              child: SpinKitCircle(size: 50, color: Colors.blue),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back_rounded),
                ),
                Text(
                  controller.ExTitles.isNotEmpty ? controller.ExTitles[0] : '',
                  style: GoogleFonts.abrilFatface(fontSize: 26),
                ),
                const SizedBox(height: 5),
                Text(
                  controller.ExAuthor.isNotEmpty ? controller.ExAuthor[0] : '',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  controller.ExSource.isNotEmpty ? controller.ExSource[0] : '',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  controller.ExDate.isNotEmpty ? controller.ExDate[0] : '',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const Divider(),
                Text(
                  controller.ExSubTitles.isNotEmpty
                      ? controller.ExSubTitles[0]
                      : '',
                  style: GoogleFonts.abyssinicaSil(fontSize: 18),
                ),
                const SizedBox(height: 10),
                if (controller.ExextractedImage.isNotEmpty &&
                    controller.ExextractedImage[0].isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      'https://news.mit.edu${controller.ExextractedImage[0]}',
                      errorBuilder: (context, error, stackTrace) =>
                          const Text("Image not available"),
                    ),
                  ),
                const SizedBox(height: 15),
                Text(
                  controller.Excontent.isNotEmpty
                      ? controller.Excontent[0]
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
