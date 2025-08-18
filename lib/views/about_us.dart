import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hacker_news/constants/app_colors.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){Get.back();}, icon:const Icon(Icons.arrow_back_ios_new_rounded) ),
            backgroundColor: AppColors.appBarTheme,
            centerTitle: true,
            title: const Text('About Us')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Developed By:',
                        style: GoogleFonts.abrilFatface(
                          textStyle:
                              const TextStyle(fontSize: 20, letterSpacing: .5),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage('assets/naved.jpg'),
                          radius: 30,
                        ),
                        title: Text(
                          'Naved Hasan',
                          style: GoogleFonts.aBeeZee(
                            textStyle: const TextStyle(
                                fontSize: 20, letterSpacing: .5),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage('assets/abdulla.jpg'),
                          radius: 30,
                        ),
                        title: Text(
                          'Abdulla Gaur',
                          style: GoogleFonts.aBeeZee(
                            textStyle: const TextStyle(
                                fontSize: 20, letterSpacing: .5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description:',
                        style: GoogleFonts.abrilFatface(
                          textStyle:
                              const TextStyle(fontSize: 20, letterSpacing: .5),
                        ),
                      ),
                      Text(
                        'Reference',
                        style: GoogleFonts.abyssinicaSil(
                          textStyle: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SelectableText(
                        'https://news.mit.edu',
                        style: GoogleFonts.abyssinicaSil(
                          textStyle: const TextStyle(fontSize: 15),
                        ),
                      ),
                      Text(
                        '\nTechnology Used                                                               ',
                        style: GoogleFonts.abyssinicaSil(
                          textStyle: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        'Flutter - For User Interface\nDart - For Webscraping\n',
                        style: GoogleFonts.abyssinicaSil(
                          textStyle: const TextStyle(fontSize: 17),
                        ),
                      ),
                      Text(
                        'Package Used',
                        style: GoogleFonts.abyssinicaSil(
                            textStyle: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                      ),
                      Text(
                        'http:\nhtml:\nflutter_easyloading: ^3.0.5\nflutter_spinkit:\nconnectivity_plus:\ndots_indicator:\ngoogle_fonts:',
                        style: GoogleFonts.abyssinicaSil(
                          textStyle: const TextStyle(fontSize: 17),
                        ),
                      ),
                      Text(
                        '\nAbout The App',
                        style: GoogleFonts.abyssinicaSil(
                            textStyle: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                      ),
                      Text(
                        'Get the website data from the mit website with the help of http package and parse through dom parser package.\nAnd shows the data in the hacker news app',
                        style: GoogleFonts.abyssinicaSil(
                          textStyle: const TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
