
import 'package:easy_exchange/redux/index.dart';
import 'package:easy_exchange/repository/currency-rates-repository.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';


Store<AppState> createStore({CurrencyRatesRepository repository}) {
  return Store(
    mainReducer,
    middleware: [thunkMiddleware],
    initialState: AppState.initial(),
  );
}