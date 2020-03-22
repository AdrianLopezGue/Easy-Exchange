import 'package:easy_exchange/networking/api_provider.dart';
import 'dart:async';
import 'package:easy_exchange/model/currency_rates.dart';
import 'package:money/money.dart';

class CurrencyRatesRepository {
  ApiProvider _provider = ApiProvider();

  Future<CurrencyRates> fetchCurrencyRates() async {
    final response = await _provider.get("");

    return CurrencyRates.fromJson(response);
  }

  Future<CurrencyRates> fetchSpecificCurrencyRates(Currency baseCurrency) async {
    final String parameterUrl = "?base=" + baseCurrency.code;

    final response = await _provider.get(parameterUrl);

    return CurrencyRates.fromJson(response);
  }
}