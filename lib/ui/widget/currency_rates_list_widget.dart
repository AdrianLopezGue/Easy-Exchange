import 'package:flutter/material.dart';
import 'package:easy_exchange/model/index.dart';


class CurrencyRateList extends StatefulWidget {
  final CurrencyRates currencyRates;
  final String currentCurrency;
  final ValueChanged<String> selectedCurrency;

  CurrencyRateList(
      {Key key,
      this.currencyRates,
      this.currentCurrency,
      this.selectedCurrency})
      : super(key: key);

  @override
  _CurrencyRateListState createState() => _CurrencyRateListState();
}

class _CurrencyRateListState extends State<CurrencyRateList> {
  String _selectedCurrency;

  @override
  void initState() {
    _selectedCurrency = widget.currentCurrency;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0,
      child: ListView.builder(
          itemCount: widget.currencyRates.rates.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(widget.currencyRates.rates[index].currency.name),
              subtitle: Text(widget.currencyRates.rates[index].currency.code),
              onTap: () {
                setState(() {
                  _selectedCurrency =
                      widget.currencyRates.rates[index].currency.code;
                });
                widget.selectedCurrency(_selectedCurrency);
                Navigator.pop(context, true);
              },
            );
          }),
    );
  }
}