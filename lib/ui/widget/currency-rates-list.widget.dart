import 'package:easy_exchange/services/bloc/currency-rate-bloc.dart';
import 'package:easy_exchange/model/index.dart';
import 'package:easy_exchange/services/networking/index.dart';
import 'package:flutter/material.dart';

typedef void StringCallback(String code, double rate);


class CurrencyRateList extends StatelessWidget {
  final String baseCurrency;
  final StringCallback callback;

  CurrencyRateList(this.baseCurrency, this.callback);

  @override
  Widget build(BuildContext context) {
    final CurrencyRatesListBloc _bloc = CurrencyRatesListBloc();

    _bloc.fetchBaseCurrencyRates(this.baseCurrency);

    return StreamBuilder<Response<CurrencyRates>>(
        stream: _bloc.currencyRatesListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());
                break;

              case Status.COMPLETED:
                return Row(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data.data.rates.length,
                          padding: EdgeInsets.all(0.0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ListTile(
                                leading: CircleAvatar(
                                  radius: 18.0,
                                  backgroundImage: AssetImage(
                                    'icons/currency/${snapshot.data.data.rates[index].currency.code.toLowerCase()}.png',
                                    package: 'currency_icons',
                                  ),
                                ),
                                title: Text(snapshot
                                    .data.data.rates[index].currency.name),
                                subtitle: Text(snapshot
                                    .data.data.rates[index].currency.code),
                                onTap: () {
                                  callback(snapshot
                                      .data.data.rates[index].currency.code, snapshot
                                      .data.data.rates[index].rate);
                                  Navigator.pop(context);
                                });
                          }),
                    ),
                  ],
                );
                break;
              case Status.ERROR:
                return Center(child: CircularProgressIndicator());
                break;
            }
          }
          return Container();
        });
  }
}
