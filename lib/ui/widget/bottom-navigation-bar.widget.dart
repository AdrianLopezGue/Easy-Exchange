import 'package:easy_exchange/ui/pages/converter.page.dart';
import 'package:easy_exchange/ui/pages/graphs.page.dart';
import 'package:easy_exchange/ui/pages/rates.page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  BottomNavigationBarWidget({Key key}) : super(key: key);

  @override
  _BottomNavigationBarState createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBarWidget> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String appBarTitle = "Converter";

  var currentTab = [
    RatesPage(),
    ExchangePage(),
    GraphsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
          title: Text(
            appBarTitle,
          ),
          centerTitle: true,
          elevation: 0.0,
        ), 
      body: IndexedStack(
        index: provider.currentIndex,
        children: currentTab,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.currentIndex,
        onTap: (index) {
          provider.currentIndex = index;
          if(index == 0){
            setState(() {
              appBarTitle = "Rates";
            });
          } else if(index == 1){
            setState(() {
              appBarTitle = "Converter";
            });
          } else if(index == 2){
            setState(() {
              appBarTitle = "Graphs";
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/dollar-sign.png'),
            activeIcon: Image.asset('assets/images/dollar-sign-active.png'),
            title: Text('Rates'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/converter.png'),
            activeIcon: Image.asset('assets/images/converter-active.png'),
            title: Text('Converter'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/graph.png'),
            activeIcon: Image.asset('assets/images/graph-active.png'),
            title: Text('Graphs'),
          ),
        ],
      ),
    );
  }
}

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 1;

  get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}