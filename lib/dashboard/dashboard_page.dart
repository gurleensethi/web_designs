import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

class _AppColors {
  static const primaryColor = Color(0xFFF4F7FD);
}

class SizingInformation {
  final DeviceType deviceType;

  SizingInformation({
    this.deviceType,
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
        body: Text('Body'),
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
    if (mediaQueryData.size.width > 1100) {
      deviceType = DeviceType.desktop;
    } else if (mediaQueryData.size.width > 600) {
      deviceType = DeviceType.tablet;
    } else {
      deviceType = DeviceType.mobile;
    }

    final sizingInformation = SizingInformation(deviceType: deviceType);

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
