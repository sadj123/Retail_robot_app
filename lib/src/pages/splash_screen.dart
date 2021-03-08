import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset('assets/imgs/img1.jpg'),
            Column(
              children: <Widget>[
                Text("Welcome,", style: Theme.of(context).textTheme.headline1),
                Text("Dear customer!",
                    style: Theme.of(context).textTheme.headline2),
              ],
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              elevation: 30,
              minWidth: 200,
              color: Theme.of(context).primaryColor,
              height: 60,
              child: Text(
                "Let's buy",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'blue');
              },
            )
          ],
        ),
      ),
    );
  }
}
