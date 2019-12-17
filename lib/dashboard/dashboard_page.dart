import 'package:flutter/material.dart';
import 'package:web_designs/dashboard/analytics_overview.dart';
import 'package:web_designs/dashboard/follower_growth.dart';
import 'package:web_designs/dashboard/like_and_comments.dart';

enum DeviceType { mobile, tablet, desktop }

class _AppColors {
  static const primaryColor = Color(0xFFF4F7FD);
}

class SizingBreakpoints {
  static const desktop = 1100.0;
  static const tablet = 600.0;
}

class SizingInformation {
  final DeviceType deviceType;
  final double width;
  final double height;

  SizingInformation({
    this.deviceType,
    this.height,
    this.width,
  });
}

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: _AppColors.primaryColor,
      ),
      home: _DashboardPage(
        body: DashboardBody(),
      ),
    );
  }
}

class _DashboardPage extends StatelessWidget {
  final Widget body;

  const _DashboardPage({
    Key key,
    this.body,
  })  : assert(body != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, options) {
        final appBar = AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            "Dashboard",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        );

        if (options.deviceType == DeviceType.desktop) {
          return Scaffold(
            appBar: appBar,
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(top: 2.0),
                    child: SideBar(),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: this.body,
                )
              ],
            ),
          );
        } else {
          return Scaffold(
            drawer: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.3,
              color: Colors.white,
              child: SideBar(),
            ),
            appBar: appBar,
            body: this.body,
          );
        }
      },
    );
  }
}

class DashboardBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 900.0),
        child: ListView(
          padding: EdgeInsets.all(40.0),
          shrinkWrap: true,
          children: <Widget>[
            AnalyticsOverview(),
            LikesAndComments(),
            FollowerGrowth(),
          ],
        ),
      ),
    );
  }
}

typedef SizingBuilder = Widget Function(
  BuildContext context,
  SizingInformation information,
);

class ResponsiveBuilder extends StatelessWidget {
  final SizingBuilder builder;
  final SizingBuilder buildMobile;
  final SizingBuilder buildTablet;
  final SizingBuilder buildDesktop;

  ResponsiveBuilder({
    Key key,
    @required this.builder,
  })  : buildMobile = null,
        buildTablet = null,
        buildDesktop = null,
        assert(builder != null),
        super(key: key);

  ResponsiveBuilder.device({
    this.buildMobile,
    this.buildTablet,
    this.buildDesktop,
  }) : builder = null;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    DeviceType deviceType;
    if (mediaQueryData.size.width > SizingBreakpoints.desktop) {
      deviceType = DeviceType.desktop;
    } else if (mediaQueryData.size.width > SizingBreakpoints.tablet) {
      deviceType = DeviceType.tablet;
    } else {
      deviceType = DeviceType.mobile;
    }

    final sizingInformation = SizingInformation(
      deviceType: deviceType,
      width: mediaQueryData.size.width,
      height: mediaQueryData.size.height,
    );

    if (builder != null) {
      return builder(context, sizingInformation);
    }

    SizingBuilder fallbackBuilder;

    switch (deviceType) {
      case DeviceType.desktop:
        fallbackBuilder = this.buildDesktop;
        break;
      case DeviceType.tablet:
        fallbackBuilder = this.buildTablet;
        break;
      case DeviceType.mobile:
        fallbackBuilder = this.buildMobile;
        break;
    }

    if (fallbackBuilder == null) {
      if (deviceType == DeviceType.desktop) {
        fallbackBuilder = buildTablet ?? buildMobile;
      } else {
        fallbackBuilder = buildMobile;
      }
    }

    return fallbackBuilder(context, sizingInformation);
  }
}

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Text('Index $index'),
              ),
            ),
          );
        },
      ),
    );
  }
}
