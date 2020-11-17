import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:robocook/photo.dart';


// A widget that displays the picture taken by the user.
class DisplayFood extends StatefulWidget {
  final String imagePath;
  final Function addPhotoCallback;

  DisplayFood({Key key, this.imagePath, this.addPhotoCallback}): super(key: key);

  @override
  _DisplayFoodState createState() => _DisplayFoodState();
}


class _DisplayFoodState extends State<DisplayFood> {
  List<Widget> _listItems = [];
  int _ingredientIndex = 7;
  int _indexOffset = 7;
  String _title;
  String _instructions;
  List<String> _ingredients = [];
  @override
  void initState() {
    super.initState();
    _listItems = [
      Card(
          child:Image.file(
              File(widget.imagePath),
              fit: BoxFit.contain,
              alignment: Alignment.center
          )
      ),
      ListTile(),
      Text(
          'Dish Name',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20
          )),
      TextField(
          decoration: InputDecoration(
              hintText: 'Name your dish',
              border: const OutlineInputBorder()
          ),
          onChanged: (String name) => setState((){_title=name;})
      ),
      ListTile(),
      Text(
          'Ingredients',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20,
          )),
      TextField(
        decoration: InputDecoration(
            hintText: '1 pound of ground beef',
          border: const OutlineInputBorder()
        ),
        onChanged: (String ingredient){
          setState((){
            if (_ingredients.length == 0) {
              _ingredients.add(ingredient);
            } else {
              _ingredients[0] = ingredient;
            }
          });
        }
      ),
      RaisedButton.icon(
          icon: Icon(Icons.add),
          label: Text("Add Ingredient"),
          onPressed: () {
            setState((){
              _listItems.insert(
                  _ingredientIndex,
                  TextField(
                    decoration: InputDecoration(
                        hintText: '1 pound of ground beef',
                        border: const OutlineInputBorder()
                    ),
                    onChanged: (String ingredient){
                      setState((){
                        if (_ingredients.length == _ingredientIndex - _indexOffset) {
                          _ingredients.add(ingredient);
                        } else {
                          _ingredients[_ingredientIndex - _indexOffset] = ingredient;
                        }
                      });
                    }
                  )
              );
              _ingredientIndex += 1;
            });
          }
      ),
      ListTile(),
      Text(
          'Instructions',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20
          )
      ),
      TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
              hintText: 'brief instruction on how to make the disk',
              border: const OutlineInputBorder()
          ),
          onChanged: (String instructions) => setState((){
            _instructions=instructions;})
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
        appBar: AppBar(title: Text('Display the Picture')),
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.
        body: ListView.builder(
          itemCount: _listItems.length,
          itemBuilder: (context, index) {
            return _listItems[index];
          }
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: (){
            print(_ingredients[0]);
            Photo photo = new Photo(_title, widget.imagePath,
                                  _ingredients, _instructions,
                                  remote: false );
            widget.addPhotoCallback(photo);
          },
        ),
    );
  }
}