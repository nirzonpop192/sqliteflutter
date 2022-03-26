import 'package:flutter/material.dart';
import '../page/index.dart';

class RouteClass extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "List of bill",
      // who will be 1st
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
      },
    );
  }
}
