import 'package:money/money.dart';


class ActionCurrencyLeftChanged {
  final Currency currencyLeft;

  const ActionCurrencyLeftChanged(this.currencyLeft);
}

class ActionCurrencyRightChanged {
  final Currency currencyRight;

  const ActionCurrencyRightChanged(this.currencyRight);
}

class ActionSetLeftAmount {
  final double leftAmount;

  const ActionSetLeftAmount(this.leftAmount);
}

class ActionSetRightAmount {
  final double rightAmount;

  const ActionSetRightAmount(this.rightAmount);
}