import 'package:money/money.dart';

final _defaultCurrencyLeft = Currency('EUR');
final _defaultCurrencyRight = Currency('USD');

class AppState {
  final RatesListState ratesListState;

  AppState(this.ratesListState);

  factory AppState.initial() => AppState(RatesListState.initial());
}

class RatesListState {
  
  final Currency currencyLeft;
  final Currency currencyRight;

  final double amountLeft;
  final double amountRight;

  RatesListState({
    this.currencyLeft,
    this.currencyRight,
    this.amountLeft,
    this.amountRight,
  });

  RatesListState copyWith({
    Currency currencyCodeLeft,
    Currency currencyCodeRight,
    double amountLeft,
    double amountRight,
    bool isLoading,
    String error
  }) {
    return RatesListState(
      currencyLeft: currencyCodeLeft ?? this.currencyLeft,
      currencyRight: currencyCodeRight ?? this.currencyRight,
      amountLeft: amountLeft ?? this.amountLeft,
      amountRight: amountRight ?? this.amountRight,
    );
  }

  factory RatesListState.initial() => RatesListState(
    currencyLeft: _defaultCurrencyLeft,
    currencyRight: _defaultCurrencyRight,
    amountLeft: 0.0,
    amountRight: 0.0,
  );
}
