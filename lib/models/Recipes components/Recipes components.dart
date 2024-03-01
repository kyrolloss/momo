class RecipeModel {
  late String? imageUrl;
  late String? title;
  late String? servings;
  late String? duration;
  late List<String>? ingredients;
  late  List<String>? steps;

  RecipeModel({
     this.imageUrl,
     this.title,
     this.servings,
     this.duration,
     this.ingredients,
     this.steps,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      imageUrl: json['Imagen de la receta'],
      title: json['Titulo de la preparacion'],
      servings: json['Raciones'],
      duration: json['Duracion'],
      ingredients: (json['Ingredientes'] as List)
          .map((ingredient) => ingredient.toString())
          .toList(),
      steps: (json['Pasos de preparacion'] as List)
          .map((step) => step.toString())
          .toList(),
    );
  }
}