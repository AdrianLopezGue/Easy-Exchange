import 'package:easy_exchange/bloc/currency_rate_bloc.dart';
import 'package:easy_exchange/model/index.dart';
import 'package:easy_exchange/networking/index.dart';
import 'package:easy_exchange/redux/index.dart';
import 'package:easy_exchange/ui/widget/index.dart';
import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:money/money.dart';

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
                          child: Text(
                              store.state.ratesListState.currencyLeft.code),
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
                                      currencyRateList(store.state.ratesListState),
                                    ]));
                          },
                        ),
                      )
                    ],
                  )
                ],
              );
            }));
  }

  Widget currencyRateList(RatesListState state) {
    CurrencyRatesListBloc _bloc;
    _bloc = CurrencyRatesListBloc();

    return StoreBuilder<AppState>(
        builder: (context, store) => StreamBuilder<Response<CurrencyRates>>(
            stream: _bloc.currencyRatesListStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    return Center(child: CircularProgressIndicator());
                    break;

                  case Status.COMPLETED:
                    return Container(
                      height: 300.0, // Change as per your requirement
                      width: 300.0,
                      child: ListView.builder(
                          itemCount: snapshot.data.data.rates.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(snapshot.data.data.rates[index].currency.name),
                              subtitle: Text(snapshot.data.data.rates[index].currency.code),
                              onTap: () {
                                store.dispatch(ActionCurrencyLeftChanged(Currency(snapshot.data.data.rates[index].currency.code)));
                                Navigator.pop(context, true);
                              },
                            );
                          }),
                    );
                    break;
                  case Status.ERROR:
                    return Center(child: CircularProgressIndicator());
                    break;
                }
              }
              return Container();
            }),
    );
  }
}
