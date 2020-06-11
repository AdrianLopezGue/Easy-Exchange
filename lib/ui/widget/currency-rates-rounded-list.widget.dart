import 'package:easy_exchange/services/bloc/currency-rate-bloc.dart';
import 'package:easy_exchange/model/index.dart';
import 'package:easy_exchange/services/networking/index.dart';
import 'package:easy_exchange/util/colors.dart';
import 'package:flutter/material.dart';

class CurrencyRateRoundedList extends StatelessWidget {
  final String baseCurrency;

  CurrencyRateRoundedList(this.baseCurrency);

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
                      child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10.0,),
                          itemCount: snapshot.data.data.rates.length,
                          padding: EdgeInsets.all(10.0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return RaisedButton(
                              color: primaryGrey,
                              child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 22.0,
                                    backgroundImage: AssetImage(
                                      'icons/currency/${snapshot.data.data.rates[index].currency.code.toLowerCase()}.png',
                                      package: 'currency_icons',
                                    ),
                                  ),
                                  title: Text(snapshot
                                      .data.data.rates[index].currency.name),
                                  subtitle: Text(snapshot
                                      .data.data.rates[index].currency.code),
                                  trailing: Text(
                                    snapshot.data.data.rates[index].rate
                                        .toStringAsFixed(5),
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),),
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                            );
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
