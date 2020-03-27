import 'package:easy_exchange/model/currency-rates.dart';
import 'package:easy_exchange/redux/actions.dart';
import 'package:easy_exchange/redux/state.dart';
import 'package:easy_exchange/services/repository/currency-rates-repository.dart';
import 'package:money/money.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> getSpecificRates(Currency baseCurrency, Currency otherCurrency) {

  CurrencyRatesRepository _repository = new CurrencyRatesRepository();

  return (Store<AppState> store) async {
    CurrencyRates rates = await _repository.fetchSpecificCurrencyRates(baseCurrency, otherCurrency);
    store.dispatch(ActionRatesUpdated(rates));
  };
}