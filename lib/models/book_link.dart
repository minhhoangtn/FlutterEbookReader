class BookLink {
  String? type;
  String? rel;
  String? title;
  String? href;

  BookLink({this.title, this.href, this.type, this.rel});

  BookLink.fromJson(Map<String, dynamic> json) {
    type = json['type'] as String?;
    rel = json['rel'] as String?;
    title = json['title'] as String?;
    href = json['href'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['type'] = type;
    data['rel'] = rel;
    data['title'] = title;
    data['href'] = href;
    return data;
  }
}
