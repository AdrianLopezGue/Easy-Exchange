import 'package:money/money.dart';

class CurrencyRates {
  final Currency baseCurrency;
  final List<Rate> rates;

  CurrencyRates([this.baseCurrency, this.rates]);

  factory CurrencyRates.fromJson(Map<String, dynamic> json) {
    final baseCurrency = json['base'];
    return CurrencyRates(
        Currency(baseCurrency), _parseRates(json['rates'], baseCurrency));
  }

  Rate getRate(int index){
    return rates[index];
  }
}

class Rate {
  Currency currency;
  double rate;

  Rate(this.currency, this.rate);
}

List<Rate> _parseRates(Map<String, dynamic> ratesMap, String baseCurrencyCode) {
  return ratesMap.keys
      .where((code) => code != baseCurrencyCode)
      .map((code) => Rate(Currency(code), ratesMap[code]))
      .toList();
}
