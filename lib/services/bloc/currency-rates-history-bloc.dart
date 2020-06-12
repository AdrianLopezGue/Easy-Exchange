import 'dart:async';

import 'package:easy_exchange/services/networking/response.dart';
import 'package:easy_exchange/services/repository/currency-rates-repository.dart';
import 'package:easy_exchange/model/currency-rates.dart';
import 'package:rxdart/subjects.dart';

class CurrencyRatesHistoryListBloc {
  CurrencyRatesRepository _currencyRatesHistoryListRepository;
  StreamController _currencyRatesHistoryListController;

  StreamSink<Response<HistoricalRates>> get currecyRatesListSink =>
      _currencyRatesHistoryListController.sink;

  Stream<Response<HistoricalRates>> get currencyRatesListStream =>
      _currencyRatesHistoryListController.stream;

  CurrencyRatesHistoryListBloc() {
    _currencyRatesHistoryListController =
        BehaviorSubject<Response<HistoricalRates>>();
    _currencyRatesHistoryListRepository = CurrencyRatesRepository();
  }

  fetchCurrencyRatesHistory(
      String baseCurrency, String destinationCurrency, int days) async {
    currecyRatesListSink.add(Response.loading('Getting Currency Rates List.'));
    try {
      HistoricalRates historicalRates = await _currencyRatesHistoryListRepository
          .fetchRatesHistory(baseCurrency, destinationCurrency, DateTime.now().subtract(Duration(days: days)), DateTime.now());

      currecyRatesListSink.add(Response.completed(historicalRates));
    } catch (e) {
      currecyRatesListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _currencyRatesHistoryListController?.close();
  }
}
