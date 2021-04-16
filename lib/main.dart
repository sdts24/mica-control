import 'package:flutter/material.dart';
import 'package:mica_control/src/pages/home_page.dart';
import 'package:mica_control/src/pages/user_page.dart';


void main() => runApp(
      MyApp(),
    );

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MICA',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'user': (BuildContext context) => UserPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
      ),
    );
  }

}
