import 'package:flutter/material.dart';
//import 'buttons.dart';
import 'main.dart';

class TestCal extends StatelessWidget {
  TestCal();
  //this is the home of our application
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Calculator(),
      ),
    );
  }
}
