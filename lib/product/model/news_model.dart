import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  String? key;
  String? url;
  String? description;
  String? image;
  String? name;
  String? source;

  News({this.key, this.url, this.description, this.image, this.name, this.source});

  News.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    url = json['url'];
    description = json['description'];
    image = json['image'];
    name = json['name'];
    source = json['source'];
  }

  factory News.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return News(
      description: data['description'],
      image: data['image'],
      name: data['name'],
      source: data['source'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['url'] = url;
    data['description'] = description;
    data['image'] = image;
    data['name'] = name;
    data['source'] = source;
    return data;
  }
}
