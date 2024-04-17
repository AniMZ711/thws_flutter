import 'package:flutter/material.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Scaffold(body: ImageGallery()));
  }
}

class ImageGallery extends StatefulWidget {
  const ImageGallery({super.key});

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  //List of image as instance varaible -> can be modified later
  List<String> images = [
    'assets/images/avatar1.PNG',
    'assets/images/avatar2.PNG',
    'assets/images/avatar3.PNG',
    'assets/images/avatar4.PNG',
  ];
  int currentIndex = 0;

  void _nextImage() {
    setState(() {
      currentIndex = (currentIndex + 1) % images.length;
    });
  }

  void _previousImage() {
    setState(() {
      currentIndex = (currentIndex - 1) % images.length;
    });
  }

// //TODO: Add form to add image
//  void _addImage() {

//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Exam - Gallery',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                images[currentIndex],
                width: 300,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: _previousImage,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 25),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: _nextImage,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
