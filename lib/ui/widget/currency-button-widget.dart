import 'package:easy_exchange/model/index.dart';
import 'package:easy_exchange/redux/index.dart';
import 'package:easy_exchange/ui/widget/currency-rate-list-widget.dart';
import 'package:flutter/material.dart';

class CurrencyButton extends StatelessWidget {

  final String text;
  final RatesListState state;
  final Function(Rate rateLeft, Rate rateRight) onTap;
  final bool flag;

  CurrencyButton(this.text, this.state, this.onTap, this.flag);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(text),
      padding: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: Colors.white,
      textColor: Colors.black,
      onPressed: () {
        showDialog(
            context: context,
            child: new SimpleDialog(
                title: new Text("Select Currency"),
                children: <Widget>[
                  CurrencyRateList(
                      onTap, state, flag),
                ]));
      },
    );
  }
}
