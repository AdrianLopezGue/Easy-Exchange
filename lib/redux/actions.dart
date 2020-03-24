import 'package:easy_exchange/model/currency-rates.dart';
import 'package:money/money.dart';


class ActionCurrencyRateLeftChanged {
  final Currency currencyLeft;
  final Currency currencyRight;

  const ActionCurrencyRateLeftChanged(this.currencyLeft, this.currencyRight);
}

class ActionCurrencyRateRightChanged {
  final Currency currencyRight;
  final double rateRight;

  const ActionCurrencyRateRightChanged(this.currencyRight, this.rateRight);
}

class ActionSetLeftAmount {
  final double leftAmount;

  const ActionSetLeftAmount(this.leftAmount);
}

class ActionRatesUpdated {
  final CurrencyRates ratesResponse;

  const ActionRatesUpdated(this.ratesResponse);
}

class ActionRatesUpdateError {
  final Object error;

  const ActionRatesUpdateError(this.error);
}