import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class GuidePage extends StatefulWidget {

  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Guide")),
        body: Center(child: Text("guide"))
    );
  }
}