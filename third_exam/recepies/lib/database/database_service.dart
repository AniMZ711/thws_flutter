import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/recipe.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database? _database;
  final Logger _logger = Logger();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'flutter_database.db');
    _logger.d("Database path: $path");
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
    );
  }

  //create table when database is created
  Future _onCreate(Database db, int version) async {
    await db.execute('DROP TABLE IF EXISTS recipes');
    await db.execute(
        'CREATE TABLE recipes (id INTEGER PRIMARY KEY, name TEXT, category TEXT, ingredients TEXT)');
    await loadRecipesFromJSON();
  }

  //read json file

  Future<void> loadRecipesFromJSON() async {
    String jsonString = await rootBundle.loadString('assets/recipes.json');
    Map<String, dynamic> jsonResponse = jsonDecode(jsonString);

    List<dynamic> recipes = jsonResponse['recipes'];

    for (var recipeJson in recipes) {
      Recipe recipe = Recipe.fromMap({
        'name': recipeJson['name'],
        'category': recipeJson['category'],
        'ingredients': recipeJson['ingredients'].join(
            ',') // Join the list of ingredients into a comma-separated string
      });

      // Insert the recipe into the database
      await DatabaseService._databaseService.insertRecipe(recipe);
    }
  }

  //insert a new recipe intp database
  Future<void> insertRecipe(Recipe recipe) async {
    final db = await database;
    await db.insert('recipes', recipe.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // retrieve all recipes from database
  Future<List<Recipe>> getRecipes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('recipes');
    return List.generate(maps.length, (i) {
      return Recipe.fromMap(maps[i]);
    });
  }

  Future<List<Recipe>> getRecipesByCategory(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('recipes', where: 'category = ?', whereArgs: [category]);
    return List.generate(maps.length, (i) {
      return Recipe.fromMap(maps[i]);
    });
  }

  Future<List<String>> getIngredientsByRecipe(String recipe) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('recipes', where: 'name = ?', whereArgs: [recipe]);

    if (maps.isNotEmpty) {
      return maps.first['ingredients'].split(',');
    }
    return [];
  }

  // update a recipe
  Future<void> updateRecipe(Recipe recipe) async {
    final db = await database;
    await db.update('recipes', recipe.toMap(),
        where: 'name = ?', whereArgs: [recipe.name]);
  }

  // delete a recipe
  Future<void> deleteRecipe(String name) async {
    final db = await database;
    await db.delete('recipes', where: 'name = ?', whereArgs: [name]);
  }

  // find a recipe by name

  Future<List<Recipe>> findByName(String name) async {
    final db = await database;
    final q = "$name%";
    final List<Map<String, dynamic>> maps =
        await db.query('recipes', where: 'name LIKE ?', whereArgs: [q]);
    return List.generate(maps.length, (i) {
      return Recipe.fromMap(maps[i]);
    });
  }

  Future<List<String>> getCategories() async {
    final db = await database;

    try {
      final List<Map<String, dynamic>> maps =
          await db.query('recipes', columns: ['DISTINCT category']);
      List<String> categories =
          maps.map((map) => map['category'] as String).toList();

      return categories;
    } catch (e) {
      _logger.e("Failed to get categories: $e");
      return [];
    }
  }
}
