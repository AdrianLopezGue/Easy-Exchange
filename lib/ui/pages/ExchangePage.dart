import 'package:easy_exchange/model/index.dart';
import 'package:easy_exchange/redux/index.dart';
import 'package:easy_exchange/ui/widget/currency-button-widget.dart';
import 'package:easy_exchange/ui/widget/currency-rate-list-widget.dart';
import 'package:easy_exchange/ui/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:money/money.dart';

class ExchangePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Easy Exchange'),
        ),
        body: StoreConnector<AppState, _ViewModel>(converter: (store) {
          return new _ViewModel(
              rateListState: store.state.ratesListState,
              getCurrencyRatesListLeft: (Rate rateLeft, Rate rateRight) {
                store.dispatch(getSpecificRates(
                    Currency(rateLeft.currency.code),
                    Currency(rateRight.currency.code)));
              },
              getCurrencyRatesListRight: (Rate rateLeft, Rate rateRight) {
                store.dispatch(ActionCurrencyRateRightChanged(
                    Currency(rateLeft.currency.code), rateRight.rate));
              },
              swap: () => store.dispatch(getSpecificRates(
                  store.state.ratesListState.currencyRateRight.currency,
                  store.state.ratesListState.currencyRateLeft.currency)));
        }, builder: (context, _ViewModel vm) {
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
                        CurrencyButton(vm.rateListState.currencyRateLeft.currency.name, vm.rateListState, vm.getCurrencyRatesListLeft, true),
                        FlatButton(
                            child: Icon(Icons.swap_horiz, color: Colors.black),
                            padding: EdgeInsets.all(10.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            color: Colors.white,
                            onPressed: vm.swap),
                        CurrencyButton(vm.rateListState.currencyRateRight.currency.name, vm.rateListState, vm.getCurrencyRatesListRight, false),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: MoneyInputLeft(
                            amount: vm.rateListState.amountLeft,
                            currency:
                                vm.rateListState.currencyRateLeft.currency),
                      ))
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.all(25.0),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text((vm.rateListState.amountRight).toString(),
                            style: new TextStyle(fontSize: 20.0)),
                      ))
                ],
              ),
            ),
          );
        }));
  }
}

class _ViewModel {
  final RatesListState rateListState;
  final Function(Rate rateLeft, Rate rateRight) getCurrencyRatesListLeft;
  final Function(Rate rateLeft, Rate rateRight) getCurrencyRatesListRight;
  final Function() swap;

  _ViewModel({
    @required this.rateListState,
    @required this.getCurrencyRatesListLeft,
    @required this.getCurrencyRatesListRight,
    @required this.swap,
  });
}
