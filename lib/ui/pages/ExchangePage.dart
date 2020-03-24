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
              return Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin: EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Row(                      
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            StoreBuilder<AppState>(
                                builder: (context, store) => FlatButton(
                                    child:
                                        Icon(Icons.swap_horiz, color: Colors.black),
                                    padding: EdgeInsets.all(10.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0)),
                                    color: Colors.white,
                                    onPressed: () {
                                      store.dispatch(getSpecificRates(store.state.ratesListState
                                              .currencyRateRight.currency,
                                          store.state.ratesListState
                                              .currencyRateLeft.currency));
                                    })),
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
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: MoneyInputLeft(
                                amount: state.amountLeft,
                                currency: state.currencyRateLeft.currency),
                          ))
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.all(25.0),
                          child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: 
                        Text(
                          (state.amountRight).toString(),
                           style: new TextStyle(
                             fontSize: 20.0
                           )
                        ),
                      ))
                    ],
                  ),
                ),
              );
            }));
  }
}
