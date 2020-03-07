import 'package:flutter/material.dart';
import 'package:easy_exchange/ui/pages/ExchangePage.dart';

void main() => runApp(EasyExchange());

class EasyExchange extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Exchange',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: ExchangePage(),
    );
  }
}
