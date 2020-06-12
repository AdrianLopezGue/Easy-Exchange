import 'package:easy_exchange/services/networking/api-provider.dart';
import 'dart:async';
import 'package:easy_exchange/model/currency-rates.dart';
import 'package:intl/intl.dart';

class CurrencyRatesRepository {
  ApiProvider _provider = ApiProvider();

  Future<CurrencyRates> fetchCurrencyRates() async {
    final response = await _provider.get("");

    return CurrencyRates.fromJson(response);
  }

  Future<CurrencyRates> fetchBaseCurrencyRates(String baseCurrency) async {
    final String parameterUrl = "latest?base=" + baseCurrency;

    final response = await _provider.get(parameterUrl);

    return CurrencyRates.fromJson(response);
  }

  Future<CurrencyRates> fetchSpecificCurrencyRates(
      String originCurrency, String destinationCurrency) async {
    final String parameterUrl =
        "latest?base=" + originCurrency + "&&symbols=" + destinationCurrency;

    final response = await _provider.get(parameterUrl);

    return CurrencyRates.fromJson(response);
  }

  Future<HistoricalRates> fetchRatesHistory(
    String originCurrency,
    String destinationCurrency,
    DateTime start,
    DateTime end,
  ) async {
    final paramDateFormat = DateFormat("yyyy-MM-dd");

    final String parameterUrl = "history?base=" +
        originCurrency +
        "&&symbols=" +
        destinationCurrency +
        "&&start_at=" +
        paramDateFormat.format(start) +
        "&&end_at=" +
        paramDateFormat.format(end);

    final response = await _provider.get(parameterUrl);

    return HistoricalRates.fromJson(response);
  }
}
