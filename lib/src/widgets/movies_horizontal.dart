import 'package:flutter/material.dart';

import 'package:movies/src/models/movie_model.dart';

class MoviesHorizontal extends StatelessWidget {
  final List<Movie> movies;

  MoviesHorizontal({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
        height: _screenSize.height * 0.2,
        child: PageView(
          children: _cards(context),
        ));
  }

  List<Widget> _cards(BuildContext context) {
    return movies.map((movie) {
      return Container(
        child: Column(
          children: [
            FadeInImage(
              fadeInDuration: Duration(milliseconds: 300),
              image: NetworkImage(movie.getPoster()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.15,
            ),
          ],
        ),
      );
    }).toList();
  }
}
