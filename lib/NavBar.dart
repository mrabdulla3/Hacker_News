import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hacker_news/Aboutus.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height / 2.1;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 230,
            child: DrawerHeader(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/hackerNews.jpg'),
                  radius: 50,
                ),
                Text(
                  'Hacker News',
                  style: GoogleFonts.abrilFatface(
                    textStyle: TextStyle(fontSize: 20, letterSpacing: .5),
                  ),
                ),
                Text(
                  'By Abdulla Gaur',
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(fontSize: 20, letterSpacing: .5),
                  ),
                ),
              ],
            )),
          ),
          ListTile(
              leading: Icon(Icons.feedback_outlined),
              title: Text('Feedback'),
              onTap: () {}),
          ListTile(
            leading: Icon(Icons.account_box_outlined),
            title: Text('About Us'),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => about_us(),
                )),
          ),
          ListTile(
              leading: Icon(Icons.contact_page_outlined),
              title: Text('Contact Us'),
              onTap: () {}),
          ListTile(
            leading: Icon(Icons.favorite_border_outlined),
            title: Text('Favorite'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}
