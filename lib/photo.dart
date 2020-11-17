import 'package:cloud_firestore/cloud_firestore.dart';

class Photo {
  String title;
  String thumbnailUrl;
  List<String> ingredients;
  String instructions;
  bool remote;
  Photo(this.title, this.thumbnailUrl, this.ingredients,
      this.instructions, {this.remote = true});

  factory Photo.fromJson(Map<String, dynamic> json){
    List<String> ingredients = [
      "1/2 cup packed brown sugar",
      "1/2 cup ketchup",
      "3/4 cup milk",
      "2 eggs",
      "1 1/2 teaspoons salt",
      "1/4 teaspoon ground black pepper",
      "1 small onion, chopped",
      "1/4 teaspoon ground ginger",
      "3/4 cup finely crushed saltine cracker crumbs"
    ];
    String instructions = "Place the chicken, butter, soup, and onion in a slow cooker, and fill with enough water to cover."
        "Cover, and cook for 5 to 6 hours on High. About 30 minutes before serving, place the torn biscuit dough in the slow cooker. Cook until the dough is no longer raw in the center";
    return Photo(json["title"], json["thumbnailUrl"], ingredients, instructions);
  }

  factory Photo.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    String title = snapshot['title'];
    String thumbnailUrl = snapshot['picture_link'];
    String instructions = snapshot['instructions'];
    List<String> ingredients = snapshot['ingredients'].cast<String>();
    return Photo(title, thumbnailUrl, ingredients, instructions);
  }

  static List<Photo> parseList(List<dynamic> list) {
    return list.map((i) => Photo.fromJson(i)).toList();
  }
}