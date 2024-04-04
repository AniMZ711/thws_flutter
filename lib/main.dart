import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'themes/myTheme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'First Portfolio Exam',
      theme: myCustomTheme,
      home: const MyHomePage(title: 'First Portfolio Exam'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            //Button press gets handled here
          },
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Theme.of(context).colorScheme.onSecondary,
                        width: 4)),
                child: SizedBox(
                  width: 200,
                  height: 100,
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Welcome",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 42,
                          // fontWeight: FontWeight.bold
                        ),
                      )),
                ))
            //welcome element
            ,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    //left box
                    width: 100,
                    height: 100,
                    color: const Color.fromARGB(255, 51, 51, 51),
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text("TAMK",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold)))),
                Container(
                    //middle box
                    width: 100,
                    height: 200,
                    color: const Color.fromARGB(255, 102, 102, 102),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text("Flutter!",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold)))),
                Container(
                    //right box
                    width: 100,
                    height: 100,
                    color: const Color.fromARGB(255, 153, 153, 153),
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text("THWS",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold))))
              ],
            ),
            Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    border: Border.all(color: Colors.grey, width: 4)),
                child: Image(
                  image: AssetImage("assets/images/thws_logo_mini.png"),
                ))
          ],
        ),
      ),
    );
  }
}
