import 'package:ebook_reader/models/id.dart';

class BookAuthor {
  Id? name;
  Id? uri;

  BookAuthor({this.name, this.uri});

  BookAuthor.fromJson(Map<String, dynamic> json) {
    name = json['name'] == null
        ? null
        : Id.fromJson(json['name'] as Map<String, dynamic>);
    uri = json['uri'] == null
        ? null
        : Id.fromJson(json['uri'] as Map<String, dynamic>);
  }
  BookAuthor.fromJsonList(List<dynamic> json) {
    name = json[0]['name'] == null
        ? null
        : Id.fromJson(json[0]['name'] as Map<String, dynamic>);
    uri = json[0]['uri'] == null
        ? null
        : Id.fromJson(json[0]['uri'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (name != null) data['name'] = name!.toJson();
    if (uri != null) data['uri'] = uri!.toJson();
    return data;
  }
}
