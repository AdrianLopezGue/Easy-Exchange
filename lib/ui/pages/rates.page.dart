import 'package:easy_exchange/ui/widget/currency-button.widget.dart';
import 'package:easy_exchange/ui/widget/currency-rates-rounded-list.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RatesPage extends StatefulWidget {
  const RatesPage({Key key}) : super(key: key);

  @override
  _RatesPageState createState() => _RatesPageState();
}

class _RatesPageState extends State<RatesPage> {
  String _originCurrencyCode = "EUR";

  @override
  Widget build(BuildContext context) {

    changeOrigenCurrency(newOrigenCurrencyCode, newOrigenCurrencyRate) {
    setState(() {
      _originCurrencyCode = newOrigenCurrencyCode;
    });
  }
  
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
          child: Column(
            children: <Widget>[
              CurrencyButton(_originCurrencyCode, changeOrigenCurrency),
              Divider(),
              CurrencyRateRoundedList(_originCurrencyCode)
          ],),
        ),
      ),
    );
  }
}