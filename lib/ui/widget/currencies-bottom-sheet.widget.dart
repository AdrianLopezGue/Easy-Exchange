import 'package:easy_exchange/ui/widget/currency-rates-list.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef void StringCallback(String code, double rate);


class CurrenciesBottomSheet extends StatefulWidget {
  final String baseCurrency;
  final StringCallback callback;

  const CurrenciesBottomSheet(this.baseCurrency, this.callback);

  @override
  _CurrenciesBottomSheetState createState() => _CurrenciesBottomSheetState();
}

class _CurrenciesBottomSheetState extends State<CurrenciesBottomSheet> {

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      minChildSize: 0.1,
      maxChildSize: 0.9,
      builder: (_, controller) {
        return Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
          ),
          child: ListView(
            controller: controller,
            children: <Widget>[
              ListTile(
                  title: Text(
                'Select a currency',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
              )),
              CurrencyRateList(widget.baseCurrency, widget.callback)
            ],
          ),
        );
      },
    );
  }
}
