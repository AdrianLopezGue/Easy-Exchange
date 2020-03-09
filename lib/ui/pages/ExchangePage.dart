import 'package:flutter/material.dart';

import 'package:easy_exchange/ui/widget/index.dart';


class ExchangePage extends StatefulWidget {
  @override
  _ExchangePage createState() => _ExchangePage();
}

class _ExchangePage extends State<ExchangePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Easy Exchange'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CurrencyButton(),
                MoneyInput()
              ],
            ),
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Text('CHANGE'),
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  color: Colors.white,
                  textColor: Colors.black,
                  onPressed: () {},
                )
              ],
            ),
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CurrencyButton(),
                MoneyInput()
              ],
            )
          ],
        ));
  }
}

