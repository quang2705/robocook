import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:robocook/photo.dart';
import 'package:robocook/fooddetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FoodPage extends StatefulWidget {
  final Function addPhotoCallback;
  FoodPage({Key key, this.addPhotoCallback}) : super(key: key);

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  bool _hasMore;
  int _pageNumber;
  bool _error;
  bool _loading;
  final int _defaultPhotoPerPageCount = 10;
  List<Photo> _photos;
  List<Widget> _foods;
  final int _nextPageThreshold = 5;

  @override
  void initState() {
    super.initState();
    _hasMore = true;
    _pageNumber = 1;
    _error = false;
    _loading = true;
    _photos = [];
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return getStreamBuilder();
  }

  Stream<QuerySnapshot> fetchFood() {
    return FirebaseFirestore.instance
            .collection('foods')
            .limit(10)
            .snapshots();
  }

  StreamBuilder<QuerySnapshot> getStreamBuilder() {
    return StreamBuilder<QuerySnapshot>(
        stream: fetchFood(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError) {
            return Center (
              child:Text("Oh no! Error! ${snapshot.error}")
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: CircularProgressIndicator()
                )
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text("No Food Found")
            ) ;
          }
          _foods = snapshot.data.documents.map<Widget>((DocumentSnapshot p) {
            Photo photo = Photo.fromDocumentSnapshot(p);
            return Card(child: Column(
                         children : <Widget>[
                           Padding(
                             padding: const EdgeInsets.all(16),
                             child: Text(photo.title,
                                 style: TextStyle(
                                     fontWeight: FontWeight.bold, fontSize: 16)),
                           ),
                           InkWell(
                               child: Image.network(
                                 photo.thumbnailUrl,
                                 fit: BoxFit.fitWidth,
                                 width: double.infinity,
                                 height: 200,
                               ),
                               onTap: ()=> _photoOnTap(context, photo)
                           ),
                           Row(
                               children: <Widget> [
                                 IconButton(
                                     icon: Icon(Icons.emoji_food_beverage),
                                     onPressed:()=> _likeOnPress(photo)
                                 ),
                                 IconButton(
                                     icon: Icon(Icons.add_comment),
                                     onPressed: ()=> _addCommentOnPress(photo)
                                 ),
                                 IconButton(
                                   icon: Icon(Icons.save),
                                   onPressed: ()=> _saveFoodOnPress(photo),
                                 )
                               ]
                           ),
                         ]
                     ));
          }).toList();
          return ListView(
              children: _foods,
          );
        });
  }

  void _likeOnPress(Photo photo) {
    print("like " + photo.title);
  }

  void _addCommentOnPress(Photo photo) {
    print("addComment " + photo.title);
  }

  void _saveFoodOnPress(Photo photo) {
    widget.addPhotoCallback(photo);
  }

  void _photoOnTap(BuildContext context, Photo photo) {
    print("photoOnTap " + photo.title);
    showDialog<void> (
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(15),
          title: Text(photo.title),
          content: FoodDetail(photo: photo),
          actions: <Widget>[
            FlatButton(
              child: const Text("OK"),
              onPressed: ()=> Navigator.pop(context),
            )
          ]
        );
      },
    );
  }

  Future<void> fetchPhotos() async {
    try {
      final response = await http.get(
          "https://jsonplaceholder.typicode.com/photos?_page=$_pageNumber");
      List<Photo> fetchedPhotos = Photo.parseList(json.decode(response.body));
      setState(() {
        _hasMore = fetchedPhotos.length == _defaultPhotoPerPageCount;
        _loading = false;
        _pageNumber = _pageNumber + 1;
        _photos.addAll(fetchedPhotos);
      });
    } catch (e) {
      setState((){
        _loading = false;
        _error = true;
      });
    }
  }

  Widget getBody() {
    if (_photos.isEmpty) {
      if (_loading) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: CircularProgressIndicator()
          )
        );
      } else if (_error) {
          return Center(
            child: InkWell(
              onTap: () {
                setState(() {
                  _loading = true;
                  _error = false;
                  fetchPhotos();
                });},
              child: Padding (
                padding: const EdgeInsets.all(16),
                child: Text("Error while loading photos, tap to try again"),
              )
            )
          );
      }
    } else {
          return ListView.builder(
            itemCount: _photos.length + (_hasMore ? 1: 0),
            itemBuilder: (context, index) {
              if (index == _photos.length - _nextPageThreshold) {
                fetchPhotos();
              }
              if (index == _photos.length) {
                if (_error) {
                  return Center(
                    child: InkWell(
                      onTap: () {
                          setState(() {
                          _loading = true;
                          _error = false;
                          fetchPhotos();
                          });},
                      child: Padding (
                        padding: const EdgeInsets.all(16),
                        child: Text("Error while loading photos, tap to try again"),
                      )
                    )
                  );
                } else {
                  return Center (
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: CircularProgressIndicator(),
                    )
                  );
                }
              }

              final Photo photo = _photos[index];
              return Card(
                child: Column(
                  children : <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(photo.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    InkWell(
                      child: Image.network(
                              photo.thumbnailUrl,
                              fit: BoxFit.fitWidth,
                              width: double.infinity,
                              height: 160,
                      ),
                      onTap: ()=> _photoOnTap(context, photo)
                    ),
                    Row(
                      children: <Widget> [
                        IconButton(
                          icon: Icon(Icons.emoji_food_beverage),
                          onPressed:()=> _likeOnPress(photo)
                        ),
                        IconButton(
                          icon: Icon(Icons.add_comment),
                          onPressed: ()=> _addCommentOnPress(photo)
                        ),
                        IconButton(
                          icon: Icon(Icons.save),
                          onPressed: ()=> _saveFoodOnPress(photo),
                        )
                      ]
                    )
                  ]
                )
              );
            }
          );
      }
    }

}


