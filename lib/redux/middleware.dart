import 'package:easy_exchange/redux/state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createMiddleware() => [
      FetchRatesMiddleware(),
    ];

class FetchRatesMiddleware implements MiddlewareClass<AppState> {

  FetchRatesMiddleware();

  @override
  void call(Store<AppState> store, action, NextDispatcher next) async {
    next(action);
  }
}
