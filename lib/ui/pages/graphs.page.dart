import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:easy_exchange/ui/widget/currency-button.widget.dart';
import 'package:easy_exchange/ui/widget/currency-history-graph.widget.dart';
import 'package:easy_exchange/ui/widget/swap-currencies-button.widget.dart';
import 'package:easy_exchange/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GraphsPage extends StatefulWidget {
  const GraphsPage({Key key}) : super(key: key);

  @override
  _GraphsPageState createState() => _GraphsPageState();
}

class _GraphsPageState extends State<GraphsPage>
    with SingleTickerProviderStateMixin {
  String _originCurrencyCode = "EUR";
  String _destinationCurrencyCode = "USD";
  int _days = 1;

  changeOrigenCurrency(newOrigenCurrencyCode, newOrigenCurrencyRate) {
    setState(() {
      _originCurrencyCode = newOrigenCurrencyCode;
    });
  }

  changeDestinationCurrency(
      newDestinationCurrencyCode, newDestinationCurrencyRate) {
    setState(() {
      _destinationCurrencyCode = newDestinationCurrencyCode;
    });
  }

  swapCurrencies() {
    setState(() {
      String temporaryString = _originCurrencyCode;
      _originCurrencyCode = _destinationCurrencyCode;
      _destinationCurrencyCode = temporaryString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CurrencyButton(_originCurrencyCode, changeOrigenCurrency),
                SwapCurrenciesButton(swapCurrencies),
                CurrencyButton(
                    _destinationCurrencyCode, changeDestinationCurrency),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: CustomRadioButton(
                      horizontal: false,
                      enableShape: true,
                      hight: 45.0,
                      customShape: CircleBorder(),
                      elevation: 2.0,
                      buttonColor: primaryGrey,
                      buttonLables: [
                        "1D",
                        "1S",
                        "1M",
                        "3M",
                        "1A",
                        "5A",
                      ],
                      buttonValues: [
                        "1",
                        "7",
                        "30",
                        "90",
                        "365",
                        "1825",
                      ],
                      radioButtonValue: (value) {
                        setState(() {
                          _days = int.parse(value);
                        });
                      },
                      selectedColor: primaryColor,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 22.0),
                  child: Text(
                      _originCurrencyCode + "/" + _destinationCurrencyCode,
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0)),
                )
              ],
            ),
            CurrencyHistoryGraph(
                _originCurrencyCode, _destinationCurrencyCode, _days)
          ],
        ),
      ),
    );
  }
}
