import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AnalyticPage extends StatefulWidget {

  @override
  _AnalyticPageState createState() => _AnalyticPageState();
}

class _AnalyticPageState extends State<AnalyticPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("My Analytic")),
        body: Center(child: Text("analytic"))
    );
  }
}