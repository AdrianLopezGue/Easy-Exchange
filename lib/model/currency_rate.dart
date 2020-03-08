import 'package:money/money.dart';

class CurrencyRate {
  final Currency baseCurrency;
  final List<Rate> rates;

  CurrencyRate([this.baseCurrency, this.rates]);

  factory CurrencyRate.fromJson(Map<String, dynamic> json) {
    final baseCurrency = json['base'];
    return CurrencyRate(
        Currency(baseCurrency), _parseRates(json['rates'], baseCurrency));
  }
}

class Rate {
  Currency currency;
  double rate;

  Rate(this.currency, this.rate);
}

List<Rate> _parseRates(Map<String, dynamic> ratesMap, String baseCurrencyCode) {
  return ratesMap.keys
      // for some currencies api return base currency in the list of rates, we need to skip it
      .where((code) => code != baseCurrencyCode)
      // rates are key values like this { "USD" : 2.333 }
      .map((code) => Rate(Currency(code), ratesMap[code]))
      .toList();
}
