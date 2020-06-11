import 'package:easy_exchange/model/index.dart';
import 'package:easy_exchange/services/repository/currency-rates-repository.dart';
import 'package:easy_exchange/ui/widget/amount-input.widget.dart';
import 'package:easy_exchange/ui/widget/currency-button.widget.dart';
import 'package:easy_exchange/ui/widget/swap-currencies-button.widget.dart';
import 'package:easy_exchange/util/colors.dart';
import 'package:flutter/material.dart';

class ExchangePage extends StatefulWidget {
  @override
  _ExchangePageState createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  String _originCurrencyCode = "EUR";
  String _destinationCurrencyCode = "USD";
  double _destinationCurrencyRate = 1.13;

  double amountToConvert = 0.0;

  CurrencyRatesRepository _repository = new CurrencyRatesRepository();

  changeOrigenCurrency(newOrigenCurrencyCode, newOrigenCurrencyRate) async {
    CurrencyRates rates = await _repository.fetchSpecificCurrencyRates(
        newOrigenCurrencyCode, _destinationCurrencyCode);

    setState(() {
      _originCurrencyCode = newOrigenCurrencyCode;
      _destinationCurrencyRate = rates.rates[0].rate;
    });
  }

  changeDestinationCurrency(
      newDestinationCurrencyCode, newDestinationCurrencyRate) async {
    CurrencyRates rates = await _repository.fetchSpecificCurrencyRates(
        _originCurrencyCode, newDestinationCurrencyCode);

    setState(() {
      _destinationCurrencyCode = newDestinationCurrencyCode;
      _destinationCurrencyRate = rates.rates[0].rate;
    });
  }

  changeAmount(newAmount) {
    setState(() {
      amountToConvert = double.parse(newAmount);
    });
  }

  swapCurrencies() async {
    CurrencyRates rates = await _repository.fetchSpecificCurrencyRates(
        _destinationCurrencyCode, _originCurrencyCode);

    setState(() {
      String temporaryString = _originCurrencyCode;
      _originCurrencyCode = _destinationCurrencyCode;
      _destinationCurrencyCode = temporaryString;
      _destinationCurrencyRate = rates.rates[0].rate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 1.1;

    return Scaffold(
      resizeToAvoidBottomInset: false,

        body: Center(
            child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Amount",
                    style: TextStyle(color: Colors.grey, fontSize: 20.0)),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                    width: halfMediaWidth,
                    height: 55.0,
                    child: AmountInput(changeAmount)),
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("From",
                        style: TextStyle(color: Colors.grey, fontSize: 20.0)),
                    SizedBox(
                      height: 10.0,
                    ),
                    CurrencyButton(_originCurrencyCode, changeOrigenCurrency),
                  ],
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40.0,
                    ),
                    SwapCurrenciesButton(swapCurrencies),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "To",
                      style: TextStyle(color: Colors.grey, fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    CurrencyButton(
                        _destinationCurrencyCode, changeDestinationCurrency),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              "1 " +
                  _originCurrencyCode +
                  " = " +
                  _destinationCurrencyRate.toString() +
                  " " +
                  _destinationCurrencyCode,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    (amountToConvert).toStringAsFixed(2),
                    style: TextStyle(
                        fontSize: 21.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold)),
                SizedBox(width: 10.0,),
                Text(_originCurrencyCode,
                    style: TextStyle(
                        fontSize: 21.0,
                        color: Colors.grey,))
              ],
            ),
            Text("=",
                style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold)),
            Text(
                (amountToConvert * _destinationCurrencyRate)
                        .toStringAsFixed(2) +
                    " " +
                    _destinationCurrencyCode,
                style: TextStyle(
                    fontSize: 45,
                    color: primaryColor,
                    fontWeight: FontWeight.bold)),
          ],
        )));
  }
}
