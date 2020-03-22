import 'package:flutter/material.dart';
import 'package:easy_exchange/ui/pages/ExchangePage.dart';
import 'package:easy_exchange/redux/index.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() => runApp(EasyExchange());

class EasyExchange extends StatelessWidget {
  
  final Store<AppState> store = createStore();
  
  @override
  Widget build(BuildContext context) => StoreProvider(
    store: this.store,
    child: MaterialApp(
      title: 'Easy Exchange',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: ExchangePage(),
    ),
  );
}