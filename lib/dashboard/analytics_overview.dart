import 'package:flutter/material.dart';
import 'package:web_designs/dashboard/dashboard_page.dart';

class AnalyticsOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Analytics Overview',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          SizedBox(height: 16.0),
          _buildList(),
        ],
      ),
    );
  }

  Widget _buildList() {
    final items = [1, 2, 3, 4].map((item) => AnalyticsListItem()).toList();
    return ResponsiveBuilder.device(
      buildDesktop: (context, info) {
        return Row(
          children: items,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        );
      },
      buildTablet: (context, info) {
        return Container(
          child: GridView.count(
            primary: false,
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: info.width / SizingBreakpoints.tablet,
            children: items,
          ),
        );
      },
      buildMobile: (context, info) {
        return ListView(
          primary: false,
          shrinkWrap: true,
          children: items,
        );
      },
    );
  }
}

class AnalyticsListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(      
      child: Card(
        elevation: 0.0,
        child: Container(
          padding: EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightBlue[200],
                ),
                child: Icon(
                  Icons.people,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 8.0),
              SelectableText(
                '21.1K',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SelectableText(
                'Total followers',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}
