
import 'package:easy_exchange/redux/index.dart';
import 'package:easy_exchange/repository/currency-rates-repository.dart';
import 'package:redux/redux.dart';


Store<AppState> createStore({CurrencyRatesRepository repository}) {
  return Store(
    mainReducer,
    middleware: createMiddleware(repository),
    initialState: AppState.initial(),
  );
}