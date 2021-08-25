import 'package:ebook_reader/models/id.dart';

class Author {
  Id? name;
  Id? uri;
  Id? email;

  Author({this.name, this.uri, this.email});

  Author.fromJson(Map<String, dynamic> json) {
    name = json['name'] == null ? null : Id.fromJson(json['name']);
    uri = json['uri'] == null ? null : Id.fromJson(json['uri']);
    email = json['email'] == null ? null : Id.fromJson(json['email']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.name != null) data['name'] = this.name!.toJson();
    if (this.uri != null) data['uri'] = this.uri!.toJson();
    if (this.email != null) data['email'] = this.email!.toJson();
    return data;
  }
}
