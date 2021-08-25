class Id {
  String? t;

  Id(this.t);

  Id.fromJson(Map<String, dynamic> json) {
    t = json['\$t'];
  }

  Map<String, dynamic> toJson() => {
        '\$t': t,
      };
}
