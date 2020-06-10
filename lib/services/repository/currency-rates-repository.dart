import 'package:easy_exchange/services/networking/api-provider.dart';
import 'dart:async';
import 'package:easy_exchange/model/currency-rates.dart';

class CurrencyRatesRepository {
  ApiProvider _provider = ApiProvider();

  Future<CurrencyRates> fetchCurrencyRates() async {
    final response = await _provider.get("");

    return CurrencyRates.fromJson(response);
  }

  Future<CurrencyRates> fetchBaseCurrencyRates(String baseCurrency) async {
    final String parameterUrl = "?base=" + baseCurrency;

    final response = await _provider.get(parameterUrl);

    return CurrencyRates.fromJson(response);
  }

  Future<CurrencyRates> fetchSpecificCurrencyRates(String originCurrency, String destinationCurrency) async {
    final String parameterUrl = "?base=" + originCurrency + "&&symbols=" + destinationCurrency;
    
    final response = await _provider.get(parameterUrl);

    return CurrencyRates.fromJson(response);
  }
}