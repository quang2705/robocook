import 'package:flutter/material.dart';
import 'package:robocook/foodpage.dart';
import 'package:robocook/camerapage.dart';
import 'package:robocook/infopage.dart';
import 'package:robocook/searchpage.dart';
import 'package:robocook/followerpage.dart';
import 'package:robocook/photo.dart';
import 'package:camera/camera.dart';


class MyHomePage extends StatefulWidget {
  final CameraDescription camera;

  MyHomePage({Key key, this.title, @required this.camera}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Photo> _myPhotos = [];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: TabBarView (
          children: <Widget>[
            FoodPage(addPhotoCallback: _addPhoto),
            CameraPage(camera: widget.camera,
                        addPhotoCallback: _addPhoto),
            InfoPage(photos: _myPhotos),
          ],
        ),
        bottomNavigationBar: Material(
          color: Theme.of(context).colorScheme.primary,
          child: TabBar(tabs: const <Widget> [
            Tab(icon: Icon(Icons.face), child: Text('Eat')),
            Tab(icon: Icon(Icons.camera), child: Text('Camera')),
            Tab(icon: Icon(Icons.accessibility_new), child: Text('Info')),
          ]),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      )
    );
  }

  void _addPhoto(Photo photo){
    _myPhotos.add(photo);
  }
}
