
import 'package:easy_exchange/redux/index.dart';
import 'package:redux/redux.dart';


Store<AppState> createStore() {
  return Store(
    mainReducer,
    middleware: createMiddleware(),
    initialState: AppState.initial(),
  );
}