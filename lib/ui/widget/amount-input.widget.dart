import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_formatter.dart';

typedef void StringCallback(String number);

class AmountInput extends StatelessWidget {

  final StringCallback callback;

  AmountInput(this.callback);

  @override
  Widget build(BuildContext context) {
    return TextField(
          maxLength: 20,
          decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
          style: TextStyle(fontSize: 18.0),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLines: 1,
          onChanged: (text) {
            callback(text);
          },
          inputFormatters: [
              MoneyInputFormatter(thousandSeparator: ThousandSeparator.None),
              BlacklistingTextInputFormatter(new RegExp('-')),
            ],
          );
  }
}