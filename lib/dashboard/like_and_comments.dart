import 'package:flutter/material.dart';
import 'package:web_designs/dashboard/dashboard_page.dart';
import 'package:web_designs/dashboard/graphs/comments_history.dart';
import 'package:web_designs/dashboard/graphs/like_history.dart';

class LikesAndComments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Likes and Comments',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          SizedBox(height: 16.0),
          ResponsiveBuilder.device(
            buildTablet: (context, info) {
              return Row(
                children: <Widget>[
                  Flexible(child: LikeHistory()),
                  Flexible(child: CommentsHistory()),
                ],
              );
            },
            buildMobile: (context, info) {
              return Column(
                children: <Widget>[
                  LikeHistory(),
                  CommentsHistory(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
