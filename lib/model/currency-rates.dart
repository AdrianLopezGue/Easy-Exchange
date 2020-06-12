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
}


class HistoricalRates {
  final Currency baseCurrency;
  final List<HistoryRatePoint> rates;

  HistoricalRates(this.baseCurrency, this.rates);

  factory HistoricalRates.fromJson(Map<String, dynamic> json) {
    final baseCurrency = json['base'];
    final Map<String, dynamic> ratesMap = json['rates'];
    return HistoricalRates(
      Currency(baseCurrency),
      ratesMap.entries.map((MapEntry<String, dynamic> entry) {
        return HistoryRatePoint(
          DateTime.parse(entry.key),
          _parseRates(entry.value, baseCurrency),
        );
      }).toList(),
    );
  }
}

class HistoryRatePoint {
  final DateTime date;
  final List<Rate> rates;

  HistoryRatePoint(this.date, this.rates);
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
