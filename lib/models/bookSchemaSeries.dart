class BookSchemaSeries {
  String? schemaPosition;
  String? schemaName;
  String? schemaUrl;

  BookSchemaSeries({this.schemaName, this.schemaPosition, this.schemaUrl});

  BookSchemaSeries.fromJson(Map<String, dynamic> json) {
    schemaPosition = json['schema:position'];
    schemaName = json['schema:name'];
    schemaUrl = json['schema:url'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['schema:position'] = this.schemaPosition;
    data['schema:name'] = this.schemaName;
    data['schema:url'] = this.schemaUrl;
    return data;
  }
}
