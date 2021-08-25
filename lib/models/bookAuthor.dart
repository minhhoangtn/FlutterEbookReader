import 'package:ebook_reader/models/id.dart';

class BookAuthor {
  Id? name;
  Id? uri;

  BookAuthor({this.name, this.uri});

  BookAuthor.fromJson(Map<String, dynamic> json) {
    name = json['name'] == null ? null : Id.fromJson(json['name']);
    uri = json['uri'] == null ? null : Id.fromJson(json['uri']);
  }
  BookAuthor.fromJsonList(List<dynamic> json) {
    name = json[0]['name'] == null ? null : Id.fromJson(json[0]['name']);
    uri = json[0]['uri'] == null ? null : Id.fromJson(json[0]['uri']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.name != null) data['name'] = this.name!.toJson();
    if (this.uri != null) data['uri'] = this.uri!.toJson();
    return data;
  }
}
