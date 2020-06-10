import 'package:easy_exchange/ui/widget/currencies-bottom-sheet.widget.dart';
import 'package:easy_exchange/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef void StringCallback(String code, double rate);

class CurrencyButton extends StatefulWidget {
  final String baseCurrency;
  final StringCallback callback;

  const CurrencyButton(this.baseCurrency, this.callback);

  @override
  _CurrencyButtonState createState() => _CurrencyButtonState();
}

class _CurrencyButtonState extends State<CurrencyButton> {

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2.0,
      color: primaryGrey,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 18.0,
                  backgroundImage: AssetImage(
                    'icons/currency/${widget.baseCurrency.toLowerCase()}.png',
                    package: 'currency_icons',
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  widget.baseCurrency,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                ),
              ],
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      textColor: Colors.black,
      onPressed: () => showModalBottomSheet(
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          context: context,
          builder: (_) => CurrenciesBottomSheet(widget.baseCurrency, widget.callback)),
    );
  }
}
