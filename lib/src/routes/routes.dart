import 'package:flutter/material.dart';
import 'package:flutter_app/src/pages/blue_screen.dart';

//Pages|Screens

import 'package:flutter_app/src/pages/main_screen.dart';
import 'package:flutter_app/src/pages/splash_screen.dart';
import 'package:flutter_app/src/pages/move_screen.dart';
import 'package:flutter_app/src/pages/order_screen.dart';

final routes = <String, WidgetBuilder>{
  'home': (BuildContext context) => SplashScreen(),
  'main': (BuildContext context) => MainScreen(),
  'blue': (BuildContext context) => HomePage(),
  'move': (BuildContext context) => MoveScreen(),
  'order': (BuildContext context) => OrderScreen(),
};
