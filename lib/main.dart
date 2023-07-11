import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

import 'pages/details_page.dart';
import 'pages/home_page.dart';
import 'pages/names_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Studio & Associate Director Details',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: 'Studio & Associate Director Details'),
      routes: {
        '/details': (context) => DetailsPage(details: []),
        '/names': (context) => NamesPage(),
      },
    );
  }
}