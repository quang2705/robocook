import 'package:flutter/material.dart';
import 'package:robocook/photo.dart';
import 'package:robocook/chefspecial.dart';
import 'package:robocook/searchpage.dart';
import 'package:robocook/historypage.dart';
import 'package:robocook/analyticpage.dart';
import 'package:robocook/guidepage.dart';
import 'package:robocook/settingpage.dart';

class InfoPage extends StatefulWidget {
  List<Photo> photos;

  InfoPage({Key key, this.photos}): super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context){
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(8),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: <Widget> [
        RaisedButton.icon(
            onPressed: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute(
                  builder: (context) => ChefSpecialPage()
                )
              );
            },
            icon: Icon(Icons.question_answer),
            label: Text("Chef Special")
        ),
        RaisedButton.icon(
            onPressed: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(photos: widget.photos)
                )
              );
            },
            icon: Icon(Icons.kitchen),
            label: Text("Recipe")
        ),
        RaisedButton.icon(
            onPressed: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryPage()
                )
              );
            },
            icon: Icon(Icons.history),
            label: Text("History")
        ),
        RaisedButton.icon(
            onPressed: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute(
                    builder: (context) => AnalyticPage()
                )
              );
            },
            icon: Icon(Icons.analytics),
            label: Text("Analytic")
        ),
        RaisedButton.icon(
            onPressed: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute(
                  builder: (context) => GuidePage()
                )
              );
            },
            icon: Icon(Icons.architecture),
            label: Text("Guide")
        ),
        RaisedButton.icon(
            onPressed: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingPage()
                )
              );
            },
            icon: Icon(Icons.settings),
            label: Text("Setting")
        ),

      ]
    );
  }
}