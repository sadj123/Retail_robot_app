import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_app/src/pages/blue_screen.dart';
import 'package:control_button/control_button.dart';

class MoveScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control',
      theme: ThemeData(
        primarySwatch: Theme.of(context).primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String text = '';

  void updateState(String showText) {
    setState(() {
      text = showText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Control Button',
              style: TextStyle(fontWeight: FontWeight.bold))
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ControlButton(
              sectionOffset: FixedAngles.Zero,
              externalDiameter: 300,
              internalDiameter: 120,
              dividerColor: Colors.white,
              elevation: 2,
              externalColor: Theme.of(context).primaryColor,
              internalColor: Colors.grey[300],
              mainAction: () => updateState('Center'),
              sections: [
                    () => updateState('Selected 2'),
                    () => updateState('Selected 1'),
                    () => updateState('Selected 4'),
                    () => updateState('Selected 3'),
              ],
            ),

            Text(
              text,
              style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}