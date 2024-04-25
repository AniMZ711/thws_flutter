import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:recepies/database/database_service.dart';

class DetailsScreen extends StatefulWidget {
  final String recipe;

  DetailsScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<String> ingredients = [];
  bool isLoading = true;
  final Logger _logger = Logger();

  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _loadIngredients();
  }

  void _loadIngredients() async {
    try {
      ingredients =
          await _databaseService.getIngredientsByRecipe(widget.recipe);
      _logger.i("Ingredients loaded successfully for recipe:${widget.recipe} ");
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
        title: Flexible(
          child: Text(
            style: const TextStyle(color: Colors.white, fontSize: 22),
            "Ingredients of ${widget.recipe}",
            softWrap: true,
            overflow: TextOverflow.fade,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: ListView.builder(
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    "${index + 1}. ${ingredients[index].trim()}",
                    textAlign: TextAlign.center,
                  ),
                );
              },
            )),
    );
  }
}
