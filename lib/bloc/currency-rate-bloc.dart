import 'dart:async';

import 'package:easy_exchange/networking/response.dart';
import 'package:easy_exchange/repository/currency-rates-repository.dart';
import 'package:easy_exchange/model/currency-rates.dart';
import 'package:rxdart/subjects.dart';

class CurrencyRatesListBloc {
  CurrencyRatesRepository _currencyRatesListRepository;
  StreamController _currencyRatesListController;

  StreamSink<Response<CurrencyRates>> get currecyRatesListSink =>
      _currencyRatesListController.sink;

  Stream<Response<CurrencyRates>> get currencyRatesListStream =>
      _currencyRatesListController.stream;

  CurrencyRatesListBloc() {
    _currencyRatesListController = BehaviorSubject<Response<CurrencyRates>>();
    _currencyRatesListRepository = CurrencyRatesRepository();
    fetchCategories();
  }

  fetchCategories() async {
    currecyRatesListSink.add(Response.loading('Getting Currency Rates List.'));
    try {
      CurrencyRates currencyRates =
          await _currencyRatesListRepository.fetchCurrencyRates();

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