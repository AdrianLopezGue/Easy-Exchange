import 'package:flutter/material.dart';

class MoneyInput extends StatefulWidget {
  @override
  _MoneyInputState createState() => _MoneyInputState();
}

class _MoneyInputState extends State<MoneyInput> {

  final textEditingController = TextEditingController();

  _printLatestValue() {
    print("Second text field: ${textEditingController.text}");
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    textEditingController.addListener(_printLatestValue);
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
      child: TextField(
        controller: textEditingController,
        keyboardType: TextInputType.number,
      ),
      width: 50.0,
    ));
  }
}