import 'package:easy_exchange/model/index.dart';
import 'package:easy_exchange/redux/index.dart';
import 'package:money/money.dart';
import 'package:redux/redux.dart';

AppState mainReducer(AppState state, dynamic action) {
  return AppState(
    ratesListReducer(state.ratesListState, action),
  );
}

Reducer<RatesListState> ratesListReducer = combineReducers([
  TypedReducer<RatesListState, ActionSetLeftAmount>(setLeftAmountReducer),
  TypedReducer<RatesListState, ActionCurrencyRateRightChanged>(currencyRateRightChangedReducer),
  TypedReducer<RatesListState, ActionRatesUpdated>(ratesUpdatedReducer),
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

RatesListState currencyRateRightChangedReducer(
  RatesListState state,
  ActionCurrencyRateRightChanged action,
) {
  return state.copyWith(
    currencyRateRight: Rate(action.currencyRight, action.rateRight),
    amountRight: state.amountLeft * action.rateRight
  );
}

RatesListState ratesUpdatedReducer(
  RatesListState state,
  ActionRatesUpdated action
  ) {

  return state.copyWith(
    currencyRateLeft: Rate(action.ratesResponse.baseCurrency, 1.0),
    currencyRateRight: Rate(action.ratesResponse.rates[0].currency, action.ratesResponse.rates[0].rate),
    amountRight: state.amountLeft * action.ratesResponse.rates[0].rate
  );
}