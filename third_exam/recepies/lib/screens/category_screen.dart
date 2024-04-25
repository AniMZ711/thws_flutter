import "package:flutter/material.dart";
import 'package:logger/logger.dart';

import 'package:recepies/database/database_service.dart';
import 'package:recepies/screens/recipe_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final DatabaseService _databaseService = DatabaseService();
  final Logger _logger = Logger();
  List<String> categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // _populateData();
    _loadCategories();
  }

  void _populateData() async {
    await _databaseService.loadRecipesFromJSON();
  }

  void _loadCategories() async {
    _logger.d("Starting to load categories.");
    try {
      categories = await _databaseService.getCategories();
      _logger.i(
          "Categories loaded successfully. Total categories: ${categories.length}");
    } catch (e) {
      _logger.e("Failed to load categories: $e");
    } finally {
      setState(() {
        isLoading = false; // Update the loading state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 78, 81, 85),
          title:
              const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.restaurant_menu, size: 26),
            SizedBox(width: 10),
            Text("Categories",
                style: TextStyle(color: Colors.white, fontSize: 26))
          ]),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 150,
                      alignment: Alignment.center,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 300,
                        ),
                        child: Card(
                          color: const Color.fromARGB(255, 255, 188, 0),
                          margin: const EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5.0,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RecipeScreen(
                                        category: categories[index])),
                              );
                            },
                            splashColor: const Color.fromARGB(255, 245, 188, 0),
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 16.0),
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                categories[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )));
  }
}
