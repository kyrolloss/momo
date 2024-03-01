class Categories {

  String? title;
  String? path;

  Categories({ this.title, this.path});

  Categories.fromJson(Map<String, dynamic> json) {
    title = json['title']as String;
    path = json['path']as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['path'] = this.path;
    return data;
  }
}
