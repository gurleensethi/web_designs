import 'package:flutter/material.dart';
import 'package:web_designs/dashboard/dashboard_page.dart';
import 'package:web_designs/dashboard/graphs/follower_growth.dart';
import 'dart:math' as math;

class FollowerGrowth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Follower Growth',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          SizedBox(height: 16.0),
          Material(
            borderRadius: BorderRadius.circular(4.0),
            color: Colors.white,
            child: ResponsiveBuilder.device(
              buildTablet: (context, info) {
                return Row(
                  children: <Widget>[
                    Expanded(
                      child: FollowerStats(),
                    ),
                    Expanded(
                      child: FollowerGrowthGraph(),
                    ),
                  ],
                );
              },
              buildMobile: (context, info) {
                return Column(
                  children: <Widget>[
                    FollowerStats(),
                    FollowerGrowthGraph(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FollowerStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _followerCount(),
          _followersGained(),
          SizedBox(height: 16.0),
          _growthPercentage(),
          SizedBox(height: 16.0),
          _followerTarget(),
        ],
      ),
    );
  }

  Widget _followerCount() {
    return Text(
      '${math.Random().nextInt(7000) + 1000}',
      style: TextStyle(
        fontSize: 64.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _followersGained() {
    return Text(
      "Gained Followers (last 30 days)",
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _growthPercentage() {
    return Row(
      children: <Widget>[
        Material(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.lightGreen[100],
          child: Icon(
            Icons.arrow_drop_up,
            color: Colors.lightGreen[700],
            size: 24.0,
          ),
        ),
        SizedBox(width: 16.0),
        Flexible(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16.0,
              ),
              children: [
                TextSpan(
                  text: 'You have a ',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                TextSpan(
                  text: '11% growth',
                  style: TextStyle(
                    color: Colors.lightGreen[700],
                  ),
                ),
                TextSpan(
                  text: ' in comparison with previous month.',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _followerTarget() {
    return Row(
      children: <Widget>[
        Material(
          elevation: 1.0,
          shape: CircleBorder(),
          child: Container(
            height: 32.0,
            width: 32.0,
            padding: EdgeInsets.all(4.0),
            child: CircularProgressIndicator(
              value: 0.7,
              strokeWidth: 3.0,
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Flexible(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16.0,
              ),
              children: [
                TextSpan(
                  text: '62%',
                  style: TextStyle(
                    color: Colors.grey[900],
                  ),
                ),
                TextSpan(
                  text: ' of 8000 followers goal.',
                  style: TextStyle(
                    color: Colors.grey,
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
