import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/recipe.dart';
import 'package:flutter/services.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database? _database;

  // Future<Database> get database async {
  //   _database ??= await _initDatabase();
  //   return _database!;
  // }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'flutter_database.db');

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
      print("Recepies loaded");
    }
  }

  //insert a new recipe intp database
  Future<void> insertRecipe(Recipe recipe) async {
    final db = await database;
    await db.insert('recipes', recipe.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // retrieve all recipes from database
  Future<List<Recipe>> recipes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('recipes');
    return List.generate(maps.length, (i) {
      return Recipe.fromMap(maps[i]);
    });
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
}
