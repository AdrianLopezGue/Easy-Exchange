import 'package:easy_exchange/redux/index.dart';
import 'package:easy_exchange/ui/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

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
        body: StoreConnector<AppState, RatesListState>(
            converter: (store) => store.state.ratesListState,
            builder: (context, state) {
              // data loaded all is ok
              return Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      StoreBuilder<AppState>(
                        builder: (context, store) => FlatButton(
                          child: Text(store.state.ratesListState
                              .currencyRateLeft.currency.name),
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          color: Colors.white,
                          textColor: Colors.black,
                          onPressed: () {
                            showDialog(
                                context: context,
                                child: new SimpleDialog(
                                    title: new Text("Select Currency"),
                                    children: <Widget>[
                                      CurrencyRateListLeft(
                                          state: store.state.ratesListState),
                                    ]));
                          },
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: MoneyInputLeft(amount: state.amountLeft, currency: state.currencyRateLeft.currency),
                        )                                              
                      ) 
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      StoreBuilder<AppState>(
                        builder: (context, store) => FlatButton(
                          child: Text(store.state.ratesListState
                              .currencyRateRight.currency.name),
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          color: Colors.white,
                          textColor: Colors.black,
                          onPressed: () {
                            showDialog(
                                context: context,
                                child: new SimpleDialog(
                                    title: new Text("Select Currency"),
                                    children: <Widget>[
                                      CurrencyRateListRight(
                                          state: store.state.ratesListState),
                                    ]));
                          },
                        ),
                      ),                      
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text((state.amountRight).toString()),
                        )                                              
                      )
                  ],)
                ],
              );
            }));
  }
}
