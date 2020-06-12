import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/src/text_style.dart' as style;
import 'package:charts_flutter/src/text_element.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:easy_exchange/model/index.dart';
import 'package:easy_exchange/services/bloc/currency-rates-history-bloc.dart';
import 'package:easy_exchange/services/networking/index.dart';
import 'package:easy_exchange/util/colors.dart';
import 'package:flutter/material.dart';


class CurrencyHistoryGraph extends StatelessWidget {
  final String originCurrency;
  final String destinationCurrency;
  final int days;

  CurrencyHistoryGraph(this.originCurrency, this.destinationCurrency, this.days);

  @override
  Widget build(BuildContext context) {
    final CurrencyRatesHistoryListBloc _bloc = CurrencyRatesHistoryListBloc();

    _bloc.fetchCurrencyRatesHistory(this.originCurrency, this.destinationCurrency, this.days);

    return StreamBuilder<Response<HistoricalRates>>(
        stream: _bloc.currencyRatesListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());
                break;

              case Status.COMPLETED:
                return Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  child: _buildHistoryChartChart(snapshot.data.data),
                  aspectRatio: 1.5,
                ),
                );
                break;
              case Status.ERROR:
                return Center(child: CircularProgressIndicator());
                break;
            }
          }
          return Container();
        });
  }

  charts.TimeSeriesChart _buildHistoryChartChart(
      HistoricalRates ratesResponse) {
    List<HistoryRatePoint> rates = ratesResponse.rates;
    rates.sort((a, b) => a.date.compareTo(b.date));

    final seriesList = _createListData(rates);
    CustomCircleSymbolRenderer render = new CustomCircleSymbolRenderer('');
    return charts.TimeSeriesChart(seriesList,
        animate: true,
        defaultRenderer: charts.LineRendererConfig(includePoints: true),
        primaryMeasureAxis: charts.NumericAxisSpec(          
          tickProviderSpec: charts.BasicNumericTickProviderSpec(            
            zeroBound: false,
            dataIsInWholeNumbers: false,
            desiredMinTickCount: 2,
            desiredMaxTickCount: 10,
          ),
        ),
        
        behaviors: [
          charts.PanAndZoomBehavior(),
          charts.LinePointHighlighter(
            symbolRenderer: render,
              showHorizontalFollowLine:
                  charts.LinePointHighlighterFollowLineType.nearest,
              showVerticalFollowLine:
                  charts.LinePointHighlighterFollowLineType.nearest),
        ],
        selectionModels: [
        SelectionModelConfig(changedListener: (SelectionModel model) {
          render.label = model.selectedSeries[0]
              .measureFn(model.selectedDatum[0].index)
              .toString();
        })
      ],
        );
  }

  static List<charts.Series<HistoryRatePoint, DateTime>> _createListData(
      List<HistoryRatePoint> data) {
    return [
      charts.Series<HistoryRatePoint, DateTime>(
        id: 'Currency',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(primaryColor),
        domainFn: (HistoryRatePoint point, _) => point.date,
        measureFn: (HistoryRatePoint point, _) => point.rates.first.rate,
        data: data,
      )
    ];
  }
}


class CustomCircleSymbolRenderer extends CircleSymbolRenderer {
  String label;

  CustomCircleSymbolRenderer(this.label);

  @override
  void paint(ChartCanvas canvas, Rectangle<num> bounds, {List<int> dashPattern, Color fillColor, Color strokeColor, double strokeWidthPx}) {
    super.paint(canvas, bounds, dashPattern: dashPattern, fillColor: fillColor, strokeColor: strokeColor, strokeWidthPx: strokeWidthPx);
    canvas.drawRect(
      Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 10, bounds.height + 10),
      fill: Color.white
    );
    var textStyle = style.TextStyle();
    textStyle.color = Color.black;
    textStyle.fontSize = 15;
    canvas.drawText(
      TextElement(this.label, style: textStyle),
        (bounds.left).round(),
        (bounds.top - 28).round()
    );
  }
}
