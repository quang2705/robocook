import 'package:flutter/material.dart';
import 'package:robocook/photo.dart';
import 'package:robocook/editfood.dart';
import 'dart:io';


class SearchPage extends StatefulWidget {
  List<Photo> photos;

  SearchPage({Key key, this.photos}): super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("My Recipe")),
      body: getBody()
    );
  }

  Widget getBody() {
    if (widget.photos.isEmpty) {
      return Center(child: Text("there is no saved food"),);
    } else {
      return ListView.builder(
        itemCount: widget.photos.length,
        itemBuilder: (context, index) {
          final Photo photo = widget.photos[index];
          Widget image;
          if (photo.remote){
            image = Image.network(
              photo.thumbnailUrl,
              fit: BoxFit.fitWidth,
              width: double.infinity,
              height: 160,
            );
          } else {
              image = Image.file(
                File(photo.thumbnailUrl),
                fit: BoxFit.fitWidth,
                width: double.infinity,
                height: 160
              );
          }
          return Card(
            child: Column(
              children: <Widget> [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(photo.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                InkWell(
                    child: image,
                    onTap: (){print(photo.title);}
                ),
                Row(children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _editOnPress(context, photo)
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteOnPress(index))
                ],)
              ],
            )
          );
        },
      );
    }
  }

  void _deleteOnPress(int index) {
    setState(() {
      widget.photos.removeAt(index);
    });
  }

  void _editOnPress(BuildContext context, Photo photo) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(15),
          title: Text(photo.title),
          content: EditFood(photo: photo),
          actions: <Widget> [
            FlatButton(
              child: const Text("Ok"),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context)
            )
          ]
        );
      }
    );
  }
}