import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:web_designs/dashboard/dashboard_page.dart';

class PostingHabits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4.0),
      elevation: 0.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(),
          Container(
            height: 1.0,
            color: Colors.grey[100],
          ),
          HabitsWidget(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Posting Habits',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(width: 16.0),
          Text(
            'Last 30 days',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          Spacer(),
          Icon(
            Icons.cloud_download,
            color: Colors.grey,
            size: 20.0,
          ),
          SizedBox(width: 16.0),
          Icon(
            Icons.menu,
            color: Colors.grey,
            size: 20.0,
          ),
        ],
      ),
    );
  }
}

class HabitsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildPostedText(),
          SizedBox(height: 24.0),
          GridMapWidget(),
        ],
      ),
    );
  }

  Widget _buildPostedText() {
    return Row(
      children: [
        Material(
          shape: CircleBorder(),
          color: Colors.blue,
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 12.0,
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Flexible(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.grey[700],
              ),
              children: [
                TextSpan(
                  text: 'You posted the most media on: ',
                ),
                TextSpan(
                  text: 'Mondays at 11am, Thursdays at 3pm, Fridays at 4am...',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

final List<String> days = [
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
  'Sun',
];

class GridMapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) {
        int crossAxisCount;
        switch (sizingInfo.deviceType) {
          case DeviceType.desktop:
            crossAxisCount = 24;
            break;
          case DeviceType.tablet:
            crossAxisCount = 16;
            break;
          case DeviceType.mobile:
            crossAxisCount = 12;
            break;
        }
        return GridView(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 6.0,
            mainAxisSpacing: 6.0,
          ),
          children:
              List.generate(crossAxisCount * 7, (item) => item).map((item) {
            if (item % crossAxisCount == 0) {
              return Container(
                child: Center(
                  child: Text(
                    days[(item / crossAxisCount).toInt()],
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            }
            Color color;
            if (math.Random().nextInt(70) == item) {
              color = Colors.blue;
            } else if (math.Random().nextInt(35) % item < 5) {
              color = Colors.blue[200].withOpacity(0.5);
            } else {
              color = Colors.blue[50].withOpacity(0.5);
            }

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: color,
              ),
              height: 24.0,
              width: 24.0,
            );
          }).toList(),
        );
      },
    );
  }
}
