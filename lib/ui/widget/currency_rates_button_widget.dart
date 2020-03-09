import 'package:flutter/material.dart';
import 'package:easy_exchange/model/currency_rates.dart';
import 'package:easy_exchange/ui/widget/index.dart';
import 'package:easy_exchange/bloc/currency_rate_bloc.dart';
import 'package:easy_exchange/networking/index.dart';

class CurrencyButton extends StatefulWidget {
  @override
  _CurrencyButtonState createState() => _CurrencyButtonState();
}

class _CurrencyButtonState extends State<CurrencyButton> {
  String selectedCurrencyCode = 'EUR';
  CurrencyRatesListBloc _bloc;

  @override
  void initState(){
    super.initState();
    _bloc = CurrencyRatesListBloc();
  }

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
                StreamBuilder<Response<CurrencyRates>>(
                    stream: _bloc.currencyRatesListStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData){
                        switch(snapshot.data.status){
                          case Status.LOADING:
                            return Center(child: CircularProgressIndicator());
                            break;
                          
                          case Status.COMPLETED:
                            return CurrencyRateList(
                              currencyRates: snapshot.data.data,
                              currentCurrency: selectedCurrencyCode,
                              selectedCurrency: (currencyCode) {
                                setState(() {
                                  selectedCurrencyCode = currencyCode;
                                });
                              });
                              break;
                          case Status.ERROR:
                            return Center(child: CircularProgressIndicator());
                            break;
                        }
                      }
                      return Container();
                    })
              ],
            ));
      },
    ));
  }
}


