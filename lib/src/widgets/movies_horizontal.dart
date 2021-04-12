import 'package:flutter/material.dart';

import 'package:movies/src/models/movie_model.dart';

class MoviesHorizontal extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPage;
  MoviesHorizontal({@required this.movies, @required this.nextPage});

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.25,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
        height: _screenSize.height * 0.2,
        // List of pages made from a list of widgets
        child: PageView.builder(
          // Allow free scrolling
          pageSnapping: false,
          controller: _pageController,
          itemCount: movies.length,
          itemBuilder: (context, index) => _card(context, movies[index]),
        ));
  }

  // Individual poster
  Widget _card(BuildContext context, Movie movie) {

    movie.uniqueId = UniqueKey().toString();

    final card = Container(
      child: Column(
        children: [
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              clipBehavior: Clip.hardEdge,
              child: FadeInImage(
                fadeInDuration: Duration(milliseconds: 300),
                image: NetworkImage(movie.getPoster()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.20,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Center(
              child: Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )),
        ],
      ),
    );

    // Widget that captures gestures
    return GestureDetector(
      child: card,
      onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
    );
  }

  // List of posters
  // List<Widget> _cards(BuildContext context) {
  //   return movies.map((movie) {
  //     return Container(
  //       child: Column(
  //         children: [
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(10.0),
  //             clipBehavior: Clip.hardEdge,
  //             child: FadeInImage(
  //               fadeInDuration: Duration(milliseconds: 300),
  //               image: NetworkImage(movie.getPoster()),
  //               placeholder: AssetImage('assets/img/no-image.jpg'),
  //               fit: BoxFit.cover,
  //               height: MediaQuery.of(context).size.height * 0.15,
  //             ),
  //           ),
  //           SizedBox(height: 5.0),
  //           Center(
  //               child: Text(
  //             movie.title,
  //             overflow: TextOverflow.ellipsis,
  //             style: Theme.of(context).textTheme.caption,
  //           )),
  //         ],
  //       ),
  //     );
  //   }).toList();
  // }
}
