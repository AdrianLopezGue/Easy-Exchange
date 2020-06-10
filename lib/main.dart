import 'package:easy_exchange/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:easy_exchange/ui/pages/ExchangePage.dart';
import 'package:flutter/services.dart';

void main() => runApp(EasyExchange());

class EasyExchange extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.white,
            /* set Status bar color in Android devices. */

            statusBarIconBrightness: Brightness.dark,
            /* set Status bar icons color in Android devices.*/

            statusBarBrightness:
                Brightness.dark) /* set Status bar icon color in iOS. */
        );

    return MaterialApp(
      title: 'Easy Exchange',
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Color(0xFFFFFFFF),
        fontFamily: 'TitilliumWeb',
        primaryTextTheme: TextTheme(
            headline6:
                TextStyle(color: primaryColor, fontSize: 26.0, fontWeight: FontWeight.bold)),
        appBarTheme:
            AppBarTheme(color: Colors.white, brightness: Brightness.light),
      ),
      home: ExchangePage(),
    );
  }
}
