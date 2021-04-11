import 'package:flutter/material.dart';

import 'package:movies/src/pages/home_page.dart';
import 'package:movies/src/pages/details_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        'details': (context) => DetailsPage(),
      },
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (context) => HomePage()),
    );
  }
}
