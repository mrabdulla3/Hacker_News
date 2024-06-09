import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class about_us extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('About')),
        body: Container(
            child: SingleChildScrollView(
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
                          textStyle: TextStyle(fontSize: 20, letterSpacing: .5),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('assets/naved.jpg'),
                          radius: 30,
                        ),
                        title: Text(
                          'Naved Hasan',
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(fontSize: 20, letterSpacing: .5),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('assets/abdulla.jpg'),
                          radius: 30,
                        ),
                        title: Text(
                          'Abdulla Gaur',
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(fontSize: 20, letterSpacing: .5),
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
                          textStyle: TextStyle(fontSize: 20, letterSpacing: .5),
                        ),
                      ),
                      Text(
                        'Reference',
                        style: GoogleFonts.abyssinicaSil(
                          textStyle: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SelectableText(
                        'https://news.mit.edu',
                        style: GoogleFonts.abyssinicaSil(
                          textStyle: TextStyle(fontSize: 15),
                        ),
                      ),
                      Text(
                        '\nTechnology Used                                                               ',
                        style: GoogleFonts.abyssinicaSil(
                          textStyle: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        'Flutter - For User Interface\nDart - For Webscraping\n',
                        style: GoogleFonts.abyssinicaSil(
                          textStyle: TextStyle(fontSize: 17),
                        ),
                      ),
                      Text(
                        'Package Used',
                        style: GoogleFonts.abyssinicaSil(
                            textStyle: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                      ),
                      Text(
                        'http:\nhtml:\nflutter_easyloading: ^3.0.5\nflutter_spinkit:\nconnectivity_plus:\ndots_indicator:\ngoogle_fonts:',
                        style: GoogleFonts.abyssinicaSil(
                          textStyle: TextStyle(fontSize: 17),
                        ),
                      ),
                      Text(
                        '\nAbout The App',
                        style: GoogleFonts.abyssinicaSil(
                            textStyle: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                      ),
                      Text(
                        'Get the website data from the mit website with the help of http package and parse through dom parser package.\nAnd shows the data in the hacker news app',
                        style: GoogleFonts.abyssinicaSil(
                          textStyle: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              //Center(child: Text('This Feature Will be Available Coming Soon!',style: TextStyle(fontSize: 25),))
                        ],
                      ),
            )));
  }
}
