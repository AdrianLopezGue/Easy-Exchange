import 'package:easy_exchange/model/index.dart';
import 'package:easy_exchange/redux/index.dart';
import 'package:redux/redux.dart';

AppState mainReducer(AppState state, dynamic action) {
  return AppState(
    ratesListReducer(state.ratesListState, action),
  );
}

Reducer<RatesListState> ratesListReducer = combineReducers([
  TypedReducer<RatesListState, ActionSetLeftAmount>(setLeftAmountReducer),
  TypedReducer<RatesListState, ActionSetRightAmount>(setRightAmountReducer),
  TypedReducer<RatesListState, ActionCurrencyLeftChanged>(currencyLeftChangedReducer),
  TypedReducer<RatesListState, ActionCurrencyRightChanged>(currencyRightChangedReducer),
]);

RatesListState setLeftAmountReducer(
  RatesListState state,
  ActionSetLeftAmount action,
) {
  return state.copyWith(
    amountLeft: action.leftAmount,
  );
}

RatesListState setRightAmountReducer(
  RatesListState state,
  ActionSetRightAmount action,
) {
  return state.copyWith(
    amountRight: action.rightAmount,
  );
}

RatesListState currencyLeftChangedReducer(
  RatesListState state,
  ActionCurrencyLeftChanged action,
) {
  return state.copyWith(
    currencyCodeLeft: action.currencyLeft,
  );
}

RatesListState currencyRightChangedReducer(
  RatesListState state,
  ActionCurrencyRightChanged action,
) {
  return state.copyWith(
    currencyCodeLeft: action.currencyRight,
  );
}