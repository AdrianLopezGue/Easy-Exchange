import 'package:easy_exchange/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef void Callback();

class SwapCurrenciesButton extends StatelessWidget {

  final Callback callback;

  const SwapCurrenciesButton(this.callback);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RawMaterialButton(
      onPressed: () {
        callback();
      },
      elevation: 2.0,
      fillColor: primaryColor,
      child: Image.asset('assets/images/switch.png',
                        fit: BoxFit.fill),
      padding: EdgeInsets.all(15.0),
      shape: CircleBorder(side: BorderSide(color: primaryGrey, width: 3.0)),
    ),
    );
  }
}