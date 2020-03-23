import 'package:easy_exchange/model/index.dart';
import 'package:money/money.dart';

final _defaultcurrencyRateLeft = Currency('EUR');
final _defaultCurrencyRateRight = Currency('USD');

class AppState {
  final RatesListState ratesListState;

  AppState(this.ratesListState);

  factory AppState.initial() => AppState(RatesListState.initial());
}

class RatesListState {
  
  final Rate currencyRateLeft;
  final Rate currencyRateRight;

  final double amountLeft;
  final double amountRight;

  RatesListState({
    this.currencyRateLeft,
    this.currencyRateRight,
    this.amountLeft,
    this.amountRight,
  });

  RatesListState copyWith({
    Rate currencyRateLeft,
    Rate currencyRateRight,
    double amountLeft,
    double amountRight,
  }) {
    return RatesListState(
      currencyRateLeft: currencyRateLeft ?? this.currencyRateLeft,
      currencyRateRight: currencyRateRight ?? this.currencyRateRight,
      amountLeft: amountLeft ?? this.amountLeft,
      amountRight: amountRight ?? this.amountRight,
    );
  }

  factory RatesListState.initial() => RatesListState(
    currencyRateLeft: Rate(_defaultcurrencyRateLeft, 1.0),
    currencyRateRight: Rate(_defaultCurrencyRateRight, 1.7),
    amountLeft: 1.0,
    amountRight: 1.7
  );
}
