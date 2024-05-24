import 'package:flutter/material.dart';
import 'package:saving_tools/pages/main/MainPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MainPage(),
      routes: {
        '/main': (context) => MainPage(),
        //TODO ADD MORE ROUTES
      },
    );
  }
}

