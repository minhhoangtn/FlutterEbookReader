class Link {
  String? rel;
  String? type;
  String? title;
  String? href;
  String? opdsActiveFacet;
  String? opdsFacetGroup;
  String? thrCount;

  Link({
    this.rel,
    this.title,
    this.type,
    this.thrCount,
    this.href,
    this.opdsActiveFacet,
    this.opdsFacetGroup,
  });

  Link.fromJson(Map<String, dynamic> json) {
    rel = json['rel'];
    title = json['title'];
    type = json['type'];
    href = json['href'];
    opdsFacetGroup = json['opds:facetGroup'];
    opdsActiveFacet = json['opds:activeFacet'];
    thrCount = json['thr:count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['rel'] = this.rel;
    data['type'] = this.type;
    data['href'] = this.href;
    data['title'] = this.title;
    data['opds:activeFacet'] = this.opdsActiveFacet;
    data['opds:facetGroup'] = this.opdsFacetGroup;
    data['thr:count'] = this.thrCount;
    return data;
  }
}
