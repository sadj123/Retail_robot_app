import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            _customAppBar(),
            _textsheader(context),
          ],
        ),
      ),
    );
  }

  Widget _customAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            iconSize: 15,
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/menu.svg',
              color: Colors.lightBlue,
            ),
          ),
          Row(
            children: <Widget>[
              IconButton(
                iconSize: 15,
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/icons/loupe.svg',
                  color: Colors.lightBlue,
                ),
              ),
              IconButton(
                iconSize: 15,
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/icons/settings.svg',
                  color: Colors.lightBlue,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _textsheader(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Hey, ', style: Theme.of(context).textTheme.bodyText1),
          Text("Ready for", style: Theme.of(context).textTheme.headline1),
          Text('Shopping?', style: Theme.of(context).textTheme.headline2)
        ],
      ),
    );
  }
}
