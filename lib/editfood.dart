import 'package:flutter/material.dart';
import 'package:robocook/photo.dart';
import 'dart:io';


class EditFood extends StatefulWidget {
  final Photo photo;

  EditFood({Key key, this.photo}): super(key: key);

  @override
  _EditFoodState createState() => _EditFoodState();
}

class _EditFoodState extends State<EditFood> {
  TextEditingController _instruction_controller;

  @override void initState() {
    // TODO: implement initState
    super.initState();
    _instruction_controller = TextEditingController(
        text: widget.photo.instructions
    );
  }
  @override
  Widget build(BuildContext context){
    Widget image;
    if (widget.photo.remote){
      image = Image.network(
        widget.photo.thumbnailUrl,
        fit: BoxFit.fitWidth,
        width: double.infinity,
        height: 160,
      );
    } else {
      image = Image.file(
          File(widget.photo.thumbnailUrl),
          fit: BoxFit.fitWidth,
          width: double.infinity,
          height: 160
      );
    }
    return Container(
        width:300,
        height: 800,
        child: ListView(
          children: <Widget> [
            image,
            Padding(
                padding: const EdgeInsets.all(8),
                child: Text("Ingredient: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20))
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.photo.ingredients.asMap().entries.map((entry){
                  TextEditingController _controller = TextEditingController(
                    text: entry.value
                  );
                  return TextField (
                    controller: _controller,
                    onChanged: (String ingredient) => {
                      widget.photo.ingredients[entry.key] = ingredient
                    }
                  );
                }).toList()
            ),
            Padding(
                padding: const EdgeInsets.all(8),
                child: Text("Instructions: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20))
            ),
            Padding(
                padding: const EdgeInsets.all(8),
                child: TextField (
                  controller: _instruction_controller,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onChanged: (String instructions) => {
                    widget.photo.instructions = instructions
                  }
                )
            )
          ],
        )
    );
  }
}