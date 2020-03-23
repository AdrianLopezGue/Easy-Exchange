import 'package:easy_exchange/bloc/currency-rate-bloc.dart';
import 'package:easy_exchange/model/index.dart';
import 'package:easy_exchange/networking/index.dart';
import 'package:easy_exchange/redux/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:money/money.dart';

class CurrencyRateListRight extends StatelessWidget {

  final RatesListState state;

  CurrencyRateListRight({Key key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final CurrencyRatesListBloc _bloc = CurrencyRatesListBloc(state.currencyRateLeft.currency);  

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
                            title: Text(
                                snapshot.data.data.rates[index].currency.name),
                            subtitle: Text(
                                snapshot.data.data.rates[index].currency.code),
                            onTap: () {
                              store.dispatch(ActionCurrencyRateRightChanged(
                                  Currency(snapshot
                                      .data.data.rates[index].currency.code),
                                  snapshot.data.data.rates[index].rate));
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