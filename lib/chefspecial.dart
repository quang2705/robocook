import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ChefSpecialPage extends StatefulWidget {

  @override
  _ChefSpecialPageState createState() => _ChefSpecialPageState();
}

class _ChefSpecialPageState extends State<ChefSpecialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Today Chef's Special")),
      body: Center(child: Text("Chef's Special"))
    );
  }
}