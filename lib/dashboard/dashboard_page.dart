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
      home: _DashboardPage(),
    );
  }
}

class _DashboardPage extends StatelessWidget {
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
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(top: 2.0),
                    child: SideBar(),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    color: Colors.red,
                    child: Text('Body'),
                  ),
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
          );
        }
      },
    );
  }
}

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, SizingInformation information)
      builder;

  const ResponsiveBuilder({
    Key key,
    @required this.builder,
  })  : assert(builder != null),
        super(key: key);

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
    return builder(context, SizingInformation(deviceType: deviceType));
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
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Text('Index $index'),
            ),
          );
        },
      ),
    );
  }
}
