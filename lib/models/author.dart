import 'package:ebook_reader/models/id.dart';

class Author {
  Id? name;
  Id? uri;
  Id? email;

  Author({this.name, this.uri, this.email});

  Author.fromJson(Map<String, dynamic> json) {
    name = json['name'] == null
        ? null
        : Id.fromJson(json['name'] as Map<String, dynamic>);
    uri = json['uri'] == null
        ? null
        : Id.fromJson(json['uri'] as Map<String, dynamic>);
    email = json['email'] == null
        ? null
        : Id.fromJson(json['email'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (name != null) data['name'] = name!.toJson();
    if (uri != null) data['uri'] = uri!.toJson();
    if (email != null) data['email'] = email!.toJson();
    return data;
  }
}
