class BookLink {
  String? type;
  String? rel;
  String? title;
  String? href;

  BookLink({this.title, this.href, this.type, this.rel});

  BookLink.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    rel = json['rel'];
    title = json['title'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['type'] = this.type;
    data['rel'] = this.rel;
    data['title'] = this.title;
    data['href'] = this.href;
    return data;
  }
}
