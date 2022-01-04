import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

String encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

final Uri emailLaunchUri = Uri(
  scheme: 'mailto',
  path: 'derekfdileo@gmail.com',
  query: encodeQueryParameters(
      <String, String>{'subject': 'Example Subject & Symbols are allowed!'}),
);

final Uri phoneLaunchUri = Uri(
  scheme: 'tel',
  path: '+1 781 316 6719',
);

// Need StatelessWidget for hot reload!
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _url = 'https://derekdileo.github.io/';

  String _email = 'derekfdileo@gmail.com';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        //appBar: AppBar(backgroundColor: Colors.deepOrange, title: Text('')),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Picture
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('images/derek.JPG'),
                ),

                // Name
                Text(
                  'Derek DiLeo',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 40.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Title
                Text(
                  'JUNIOR DEVELOPER',
                  style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                // Line Separator
                SizedBox(
                  height: 20.0,
                  width: 150.0,
                  child: Divider(
                    color: Colors.black,
                  ),
                ),

                // Phone
                Card(
                  color: Colors.white,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      launch(phoneLaunchUri.toString());
                      print('phone pressed');
                    },
                  ),
                ),

                // Email
                Card(
                  color: Colors.white,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      launch(emailLaunchUri.toString());
                      print('email pressed');
                    },
                  ),
                ),

                // Link to website
                Card(
                  color: Colors.white,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: IconButton(
                      icon: Icon(
                        Icons.link,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        launch(_url);
                        print('link pressed');
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
