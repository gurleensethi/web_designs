import 'package:flutter/material.dart';

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
      margin: EdgeInsets.only(right: 8.0),
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
