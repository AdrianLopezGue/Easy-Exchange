import 'package:easy_exchange/networking/api_provider.dart';
import 'dart:async';
import 'package:easy_exchange/model/currency_rates.dart';

class CurrencyRatesListRepository {
  ApiProvider _provider = ApiProvider();

  Future<CurrencyRates> fetchCurrencyRates() async {
    final response = await _provider.get("");

    return CurrencyRates.fromJson(response);
  }
}