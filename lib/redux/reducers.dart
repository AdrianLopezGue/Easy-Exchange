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
  TypedReducer<RatesListState, ActionCurrencyRateLeftChanged>(currencyRateLeftChangedReducer),
  TypedReducer<RatesListState, ActionCurrencyRateRightChanged>(currencyRateRightChangedReducer),
]);

RatesListState setLeftAmountReducer(
  RatesListState state,
  ActionSetLeftAmount action,
) {
  return state.copyWith(
    amountLeft: action.leftAmount,
    amountRight: action.leftAmount * state.currencyRateRight.rate
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

RatesListState currencyRateLeftChangedReducer(
  RatesListState state,
  ActionCurrencyRateLeftChanged action,
) {
  return state.copyWith(
    currencyRateLeft: Rate(action.currencyLeft, action.rateLeft),
    amountRight: state.amountLeft * state.currencyRateRight.rate
  );
}

RatesListState currencyRateRightChangedReducer(
  RatesListState state,
  ActionCurrencyRateRightChanged action,
) {
  return state.copyWith(
    currencyRateRight: Rate(action.currencyRight, action.rateRight),
    amountRight: state.amountLeft * action.rateRight
  );
}