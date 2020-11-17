import 'package:flutter/material.dart';
import 'package:robocook/photo.dart';


class FoodDetail extends StatefulWidget {
  final Photo photo;

  FoodDetail({Key key, this.photo}): super(key: key);

  @override
  _FoodDetailState createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  @override
  Widget build(BuildContext context){
    return Container(
      width:300,
      height: 800,
      child: ListView(
        children: <Widget> [
          Image.network(
            widget.photo.thumbnailUrl,
            fit: BoxFit.contain,
            width: 300,
            height: 300,
          ),
          Padding(
              padding: const EdgeInsets.all(8),
              child: Text("Ingredient: ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20))
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.photo.ingredients.map((i) => Text(i)).toList()
          ),
          Padding(
              padding: const EdgeInsets.all(8),
              child: Text("Instructions: ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20))
          ),
          Padding(
              padding: const EdgeInsets.all(8),
              child: Text(widget.photo.instructions)
          )
          ],
        )
      );

  }
}