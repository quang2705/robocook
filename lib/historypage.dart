import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HistoryPage extends StatefulWidget {

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("My History")),
        body: Center(child: Text("my history"))
    );
  }
}