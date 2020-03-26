import 'package:easy_exchange/bloc/currency-rate-bloc.dart';
import 'package:easy_exchange/model/index.dart';
import 'package:easy_exchange/networking/index.dart';
import 'package:easy_exchange/redux/index.dart';
import 'package:flutter/material.dart';

class CurrencyRateList extends StatelessWidget {
  final RatesListState state;
  final Function(Rate rateLeft, Rate rateRight) onTap;
  final bool isLeft;

  CurrencyRateList(this.onTap, this.state, this.isLeft);

  @override
  Widget build(BuildContext context) {
    final CurrencyRatesListBloc _bloc =
        CurrencyRatesListBloc(state.currencyRateLeft.currency);

    return StreamBuilder<Response<CurrencyRates>>(
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
                          onTap: (){
                            if(isLeft){
                              this.onTap(snapshot.data.data.rates[index], state.currencyRateRight);
                            }
                            else{
                              this.onTap(snapshot.data.data.rates[index], snapshot.data.data.rates[index]);
                            }

                            Navigator.pop(context, true);
                          } 
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
        });
  }
}
