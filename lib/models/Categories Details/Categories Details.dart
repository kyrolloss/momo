class Categoriesdetails {
  String? image;
  String? title;
  String? path;

  Categoriesdetails({this.image, this.title ,  this.path});

  Categoriesdetails.fromJson(Map<String, dynamic> json) {
    image = json['image'] as String;
    title = json['title']as String;
    path = json['path']as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    data['path'] = this.path;
    return data;
  }
}
