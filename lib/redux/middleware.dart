import 'package:easy_exchange/model/currency-rates.dart';
import 'package:easy_exchange/redux/actions.dart';
import 'package:easy_exchange/redux/state.dart';
import 'package:easy_exchange/repository/currency-rates-repository.dart';
import 'package:money/money.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createMiddleware(CurrencyRatesRepository repository) => [
      FetchRatesMiddleware(repository),
    ];

class FetchRatesMiddleware implements MiddlewareClass<AppState> {
  final CurrencyRatesRepository _repository;

  FetchRatesMiddleware(this._repository);

  @override
  void call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is ActionCurrencyRateLeftChanged) {
      await _loadRates(next, action.currencyLeft, action.currencyRight);
    } 
    else{
    next(action);
    }
  }

  Future _loadRates(NextDispatcher next, Currency baseCurrency, Currency anotherCurrency) async {

    try {
      CurrencyRates result = await _repository.fetchSpecificCurrencyRates(baseCurrency, anotherCurrency);
      next(ActionRatesUpdated(result));
    } catch (e) {
      if (e is Exception) {
        e.toString();
      }
      print(e);
      next(ActionRatesUpdateError(e));
    }
  }
}
