import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math' as math;
import 'package:web_designs/dashboard/dashboard_page.dart';

class CommentsHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildTopBar(),
          _buildGraph(),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Text(
            'Comments History',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGraph() {
    return ResponsiveBuilder(
      builder: (context, info) {
        double height = 400.0;
        switch (info.deviceType) {
          case DeviceType.desktop:
            height = 400.0;
            break;
          case DeviceType.tablet:
            height = 300.0;
            break;
          case DeviceType.mobile:
            height = 200.0;
            break;
        }
        return Container(
          height: height,
          padding: EdgeInsets.all(16.0),
          child: charts.LineChart(
            _getSampleData(),
          ),
        );
      },
    );
  }

  List<charts.Series<int, int>> _getSampleData() {
    return [
      charts.Series(
        id: 'Likes',
        data: List.generate(10, (index) {
          final num = math.Random().nextInt((index + 1) * 20);
          return num;
        }),
        measureFn: (data, index) => data,
        domainFn: (data, index) => index,
        dashPatternFn: (data, index) {
          if (index == 3 || index == 7) {
            return [3, 3];
          }
          return null;
        },
        colorFn: (data, index) {
          return charts.Color.fromHex(
            code: Colors.red.value.toRadixString(16),
          );
        },
      ),
    ];
  }
}
