//

class Recipe {
  late String name;
  late String category;
  late List<String> ingredients;

  Recipe(
      {required this.name, required this.category, required this.ingredients});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'ingredients': ingredients.join(','),
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      name: map['name'],
      category: map['category'],
      ingredients: map['ingredients'].split(','),
    );
  }
}
