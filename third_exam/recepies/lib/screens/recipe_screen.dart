import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:recepies/database/database_service.dart';
import '../models/recipe.dart';
import 'package:recepies/screens/details_screen.dart';

class RecipeScreen extends StatefulWidget {
  final String category;
  const RecipeScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  List<Recipe> recipes = [];
  bool isLoading = true;
  final Logger _logger = Logger();
  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  void _loadRecipes() async {
    try {
      recipes = await _databaseService.getRecipesByCategory(widget.category);
      _logger.i("Recipes loaded successfully for category: ");
    } catch (e) {
      _logger.e("Failed to load recipes: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 78, 81, 85),
        title: Text("Recipes in ${widget.category.toUpperCase()}",
            style: const TextStyle(color: Colors.white, fontSize: 22)),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8, 10, 8, 0),
                    child: Text(
                      "Select a recipe from the list below:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 100,
                        alignment: Alignment.center,
                        child: Card(
                          color: const Color.fromARGB(255, 245, 188, 0),
                          margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                          child: ListTile(
                            title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    recipes[index].name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 54, 54, 54),
                                        fontSize: 20),
                                  ),
                                  const SizedBox(width: 10),
                                  const Icon(Icons.info,
                                      size: 26,
                                      color: Color.fromARGB(255, 85, 85, 85)),
                                ]),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                      recipe: recipes[index].name),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
