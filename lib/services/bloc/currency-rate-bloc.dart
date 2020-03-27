import 'dart:async';

import 'package:easy_exchange/services/networking/response.dart';
import 'package:easy_exchange/services/repository/currency-rates-repository.dart';
import 'package:easy_exchange/model/currency-rates.dart';
import 'package:money/money.dart';
import 'package:rxdart/subjects.dart';

class CurrencyRatesListBloc {
  CurrencyRatesRepository _currencyRatesListRepository;
  StreamController _currencyRatesListController;

  StreamSink<Response<CurrencyRates>> get currecyRatesListSink =>
      _currencyRatesListController.sink;

  Stream<Response<CurrencyRates>> get currencyRatesListStream =>
      _currencyRatesListController.stream;

  CurrencyRatesListBloc(Currency baseCurrency) {
    _currencyRatesListController = BehaviorSubject<Response<CurrencyRates>>();
    _currencyRatesListRepository = CurrencyRatesRepository();
    fetchBaseCurrencyRates(baseCurrency);
  }

  fetchBaseCurrencyRates(Currency baseCurrency) async {
    currecyRatesListSink.add(Response.loading('Getting Currency Rates List.'));
    try {
      CurrencyRates currencyRates =
          await _currencyRatesListRepository.fetchBaseCurrencyRates(baseCurrency);

      currecyRatesListSink.add(Response.completed(currencyRates));
    } catch (e) {
      currecyRatesListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _currencyRatesListController?.close();
  }
}