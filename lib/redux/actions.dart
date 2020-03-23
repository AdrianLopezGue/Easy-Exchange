import 'package:money/money.dart';


class ActionCurrencyRateLeftChanged {
  final Currency currencyLeft;
  final double rateLeft;

  const ActionCurrencyRateLeftChanged(this.currencyLeft, this.rateLeft);
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

class ActionSetRightAmount {
  final double rightAmount;

  const ActionSetRightAmount(this.rightAmount);
}