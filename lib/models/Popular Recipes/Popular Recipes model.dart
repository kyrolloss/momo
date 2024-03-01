class PopularRecipes {
  String? image;
  String? title;
  String? newCategory;
  String? path;

  PopularRecipes({this.image, this.title, this.newCategory, this.path});

  PopularRecipes.fromJson(Map<String, dynamic> json) {
    image = json['image'] as String;
    title = json['title']as String;
    newCategory = json['newCategory']as String;
    path = json['path']as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    data['newCategory'] = this.newCategory;
    data['path'] = this.path;
    return data;
  }
}
