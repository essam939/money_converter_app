import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// Example data model
class CurrencyData {
  final DateTime date;
  final double exchangeRate;
  final double goldPrice;

  CurrencyData(this.date, this.exchangeRate, this.goldPrice);
}

class CurrencyChart extends StatelessWidget {
  final List<CurrencyData> data;

  CurrencyChart(this.data);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<CurrencyData, DateTime>> series = [
      charts.Series(
        id: "Exchange Rate",
        data: data,
        domainFn: (CurrencyData data, _) => data.date,
        measureFn: (CurrencyData data, _) => data.exchangeRate,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        displayName: "Exchange Rate",
      ),
      charts.Series(
        id: "Gold Price",
        data: data,
        domainFn: (CurrencyData data, _) => data.date,
        measureFn: (CurrencyData data, _) => data.goldPrice,
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
        displayName: "Gold Price",
      ),
    ];

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
          height: 300,
          child: charts.TimeSeriesChart(
            series,
            animate: true,
            dateTimeFactory: const charts.LocalDateTimeFactory(),
            defaultRenderer: charts.LineRendererConfig(includePoints: true),
            behaviors: [
              charts.SeriesLegend(),
            ],
          ),
        ),
      ),
    );
  }
}

