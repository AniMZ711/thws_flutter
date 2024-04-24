import 'package:flutter/material.dart';
import 'package:recepies/models/recipe.dart';
import 'package:recepies/database/database_service.dart';
import 'package:logger/logger.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Database Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DatabaseService _databaseService = DatabaseService();
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future<void>(() => _loadRecepiesFromJSON());
  }

  void _loadRecepiesFromJSON() async {
    await _databaseService.loadRecipesFromJSON();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void _onChanged(String input) {
    var input = textController.text;
    _databaseService.findByName(input).then((value) {
      for (var v in value) {
        Logger().i(
            "Recipe ${v.name} with category ${v.category}, and ingredients ${v.ingredients}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Search Recipe by name:',
            ),
            TextField(
              controller: textController,
              onChanged: _onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
