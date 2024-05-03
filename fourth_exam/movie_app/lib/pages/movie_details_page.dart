import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie_app/models/movie.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DetailsPage extends StatefulWidget {
  final Movie movie;

  DetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(widget.movie.title,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (widget.movie.images.isNotEmpty)
                ? Container(
                    padding: EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width,
                    color: Color.fromARGB(255, 52, 49, 49),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        autoPlay: false,
                      ),
                      items: widget.movie.images
                          .map((item) => Container(
                                child: Center(
                                  child: Image.network(item,
                                      fit: BoxFit.cover, width: 1000),
                                ),
                              ))
                          .toList(),
                    ))
                : Image.network(
                    'https://via.placeholder.com/150',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.movie.genre),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.movie.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.favorite_border_outlined)
                      ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    const Icon(Icons.timelapse),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.movie.runtime,
                      style: const TextStyle(fontSize: 16),
                    )
                  ]),
                  SizedBox(height: 5),
                  Row(children: [
                    Icon(Icons.star),
                    SizedBox(width: 10),
                    Text(
                      "IMDb Rating: ${widget.movie.imdbRating}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ]),
                  SizedBox(height: 20),
                  Text(
                    "Description:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.movie.plot,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
