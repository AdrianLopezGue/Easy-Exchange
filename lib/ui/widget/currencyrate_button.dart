import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:easy_exchange/util/url.dart';
import 'package:easy_exchange/model/currency_rate.dart';
import 'package:http/http.dart' as http;

Future<CurrencyRate> fetchCurrencyRate(http.Client client) async {
  final response = await client.get(Url.exchangeBaseUrl);

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);

    return CurrencyRate.fromJson(parsed);
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load currencies');
  }
}

class CurrencyButton extends StatefulWidget {
  @override
  _CurrencyButtonState createState() => _CurrencyButtonState();
}

class _CurrencyButtonState extends State<CurrencyButton> {
  String selectedCurrencyCode = 'EUR';

  @override
  Widget build(BuildContext context) {
    return (FlatButton(
      child: Text('$selectedCurrencyCode'),
      padding: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: Colors.white,
      textColor: Colors.black,
      onPressed: () {
        showDialog(
            context: context,
            child: new SimpleDialog(
              title: new Text("Select Currency"),
              children: <Widget>[
                FutureBuilder<CurrencyRate>(
                    future: fetchCurrencyRate(http.Client()),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);

                      return snapshot.hasData
                          ? CurrencyRateList(
                              currencyRates: snapshot.data,
                              currentCurrency: selectedCurrencyCode,
                              selectedCurrency: (currencyCode) {
                                setState(() {
                                  selectedCurrencyCode = currencyCode;
                                });
                              })
                          : Center(child: CircularProgressIndicator());
                    })
              ],
            ));
      },
    ));
  }
}

class CurrencyRateList extends StatefulWidget {
  final CurrencyRate currencyRates;
  final String currentCurrency;
  final ValueChanged<String> selectedCurrency;

  CurrencyRateList(
      {Key key,
      this.currencyRates,
      this.currentCurrency,
      this.selectedCurrency})
      : super(key: key);

  @override
  _CurrencyRateListState createState() => _CurrencyRateListState();
}

class _CurrencyRateListState extends State<CurrencyRateList> {
  String _selectedCurrency;

  @override
  void initState() {
    _selectedCurrency = widget.currentCurrency;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0,
      child: ListView.builder(
          itemCount: widget.currencyRates.rates.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(widget.currencyRates.rates[index].currency.name),
              subtitle: Text(widget.currencyRates.rates[index].currency.code),
              onTap: () {
                setState(() {
                  _selectedCurrency =
                      widget.currencyRates.rates[index].currency.code;
                });
                widget.selectedCurrency(_selectedCurrency);
                Navigator.pop(context, true);
              },
            );
          }),
    );
  }
}
