import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hacker_news/views/about_us.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height / 2.1;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: screenHeight * 0.8,
            child: DrawerHeader(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const  CircleAvatar(
                  backgroundImage: AssetImage('assets/hackerNews.jpg'),
                  radius: 50,
                ),
                Text(
                  'Hacker News',
                  style: GoogleFonts.abrilFatface(
                    textStyle:const TextStyle(fontSize: 20, letterSpacing: .5),
                  ),
                ),
                Text(
                  'By Abdulla Gaur',
                  style: GoogleFonts.aBeeZee(
                    textStyle:const TextStyle(fontSize: 20, letterSpacing: .5),
                  ),
                ),
              ],
            )),
          ),
          ListTile(
              leading:const Icon(Icons.feedback_outlined),
              title:const Text('Feedback'),
              onTap: () {}),
          ListTile(
            leading:const Icon(Icons.account_box_outlined),
            title:const Text('About Us'),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutUs(),
                )),
          ),
          ListTile(
              leading:const Icon(Icons.contact_page_outlined),
              title:const Text('Contact Us'),
              onTap: () {}),
          ListTile(
            leading:const Icon(Icons.favorite_border_outlined),
            title:const Text('Favorite'),
            onTap: () {},
          ),
          ListTile(
            leading:const Icon(Icons.settings),
            title:const Text('Settings'),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}
