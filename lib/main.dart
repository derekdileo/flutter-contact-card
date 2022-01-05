import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

// First part of url_launcher for email configuration
String encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

// Second part of url_launcher for email configuration
final Uri emailLaunchUri = Uri(
  scheme: 'mailto',
  path: 'derekfdileo@gmail.com',
  query: encodeQueryParameters(<String, String>{'subject': 'Job Opportunity'}),
);

// url_launcher configuration for phone
final Uri phoneLaunchUri = Uri(
  scheme: 'tel',
  path: '+1 781 316 6719',
);

// StatelessWidgets required for hot reload!
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _url = 'https://derekdileo.github.io/';

  // Function (called by buildCard) to choose between three uri functions.
  void uriChoice(int i) {
    if (i != 1 && i != 2 && i != 3) {
      return;
    }
    if (i == 1) {
      launch(phoneLaunchUri.toString());
    } else if (i == 2) {
      launch(emailLaunchUri.toString());
    } else {
      launch(_url);
    }
  }

  // Function to build Name and Title fields
  Text contactInfo(String info, String fontFamily, double fontSize) {
    return Text(
      '$info',
      style: TextStyle(
        fontFamily: '$fontFamily',
        fontSize: fontSize,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /* Function to build each of three contact card Widgets.
  *  choice: allows for one of three options for uri launcher (phone, email, website)
  *  iconName: choose which icon to display
  *  message: print message for debug / testing
  *  label: label for each Card (phone number, email address, website) */
  Card buildCard(int choice, IconData iconName, String message, String label) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      child: Center(
        child: TextButton.icon(
          onPressed: () {
            uriChoice(choice);
            print('$message');
          },
          icon: Icon(
            iconName,
          ),
          label: Text(
            '$label',
            style: TextStyle(
              fontFamily: 'Source Sans Pro',
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ThemeData affects all buttons in app!
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.black,
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        //appBar: AppBar(backgroundColor: Colors.deepOrange, title: Text('')),
        body: SafeArea(
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
              contactInfo('Derek DiLeo', 'Pacifico', 40.0),

              // Title
              contactInfo('JUNIOR DEVELOPER', 'Source Sans Pro', 20.0),

              // Line Separator
              SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(
                  color: Colors.black,
                ),
              ),

              // Link to Website
              buildCard(3, Icons.link, 'link pressed', 'View Website'),

              // Email
              buildCard(2, Icons.email, 'email pressed', 'Send Email'),

              // Phone
              buildCard(1, Icons.phone, 'phone pressed', 'Call Me'),
            ],
          ),
        ),
      ),
    );
  }
}
