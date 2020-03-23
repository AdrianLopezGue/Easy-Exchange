import 'package:easy_exchange/redux/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:money/money.dart';

class MoneyInput extends StatefulWidget {

  final double amount;
  final Currency currency;

  const MoneyInput({this.amount, this.currency});

  @override
  _MoneyInputState createState() => _MoneyInputState();
}

class _MoneyInputState extends State<MoneyInput> {

  var text;

  TextEditingController inputController;

  @override
  void initState(){
    text = Money.fromDouble(widget.amount, widget.currency).amountAsString;
    inputController= new TextEditingController(text: text);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return (StoreBuilder<AppState>(
      builder: (context, store) {   

      return TextField(
          controller: inputController,
          keyboardType: TextInputType.number,  
          textAlign: TextAlign.center,
          maxLines: 1,        
          onChanged: (text){
            store.dispatch(ActionSetLeftAmount(double.parse(text)));
          }
      );
      }       
    ));
  }
}