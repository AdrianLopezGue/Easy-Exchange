import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:easy_exchange/util/url.dart';
import 'package:easy_exchange/model/currency_rate.dart';


Future<CurrencyRate> fetchCurrencyRate(http.Client client) async {
  
  final response = await client.get(Url.exchangeBaseUrl);

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);

    return CurrencyRate.fromJson(parsed);
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load album');
  }

}

class ExchangePage extends StatefulWidget {
  @override
  _ExchangePage createState() => _ExchangePage();
}

class _ExchangePage extends State<ExchangePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Easy Exchange'),
        ),
        body: FutureBuilder<CurrencyRate>(
            future: fetchCurrencyRate(http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasError)
                print(snapshot.error);
              else
                print("check");

              return snapshot.hasData
                  ? CurrencyRateList(currencyRates: snapshot.data)
                  : Center(child: CircularProgressIndicator());
            }));
  }
}

class CurrencyRateList extends StatelessWidget {
  final CurrencyRate currencyRates;

  CurrencyRateList({Key key, this.currencyRates}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      itemCount: currencyRates.rates.length,
      itemBuilder: (context, index) {
        return Row(children: <Widget>[
          Text(currencyRates.rates[index].currency.name),
          Text(currencyRates.rates[index].currency.code),
          Text(currencyRates.rates[index].rate.toString()),
        ],
        ); 
      },
    );
  }
}
