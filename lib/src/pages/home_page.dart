import 'package:flutter/material.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/search/search_delegate.dart';
import 'package:movies/src/widgets/card_swiper.dart';
import 'package:movies/src/widgets/movies_horizontal.dart';

import '../models/movie_model.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    moviesProvider.getPopular();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cartelera'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _CardSwiper(moviesProvider: moviesProvider),
            _Footer(moviesProvider: moviesProvider),
          ],
        ),
      ),
    );
  }
}

class _CardSwiper extends StatelessWidget {
  const _CardSwiper({
    Key? key,
    required this.moviesProvider,
  }) : super(key: key);

  final MoviesProvider moviesProvider;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Movie list
      future: moviesProvider.getInTheatres(),
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return CardSwiper(movieList: snapshot.data as List<Movie>);
        else {
          return Container(
            height: 300.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({
    Key? key,
    required this.moviesProvider,
  }) : super(key: key);

  final MoviesProvider moviesProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(left: 15.0),
              child: Text('Populares',
                  style: Theme.of(context).textTheme.titleMedium)),
          SizedBox(height: 15.0),
          // Build movie PageView from the moviesProvider's stream
          StreamBuilder(
              stream: moviesProvider.popularStream,
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return MoviesHorizontal(
                      movies: snapshot.data as List<Movie>,
                      nextPage: moviesProvider.getPopular);
                else
                  return Center(child: CircularProgressIndicator());
              }),
        ],
      ),
    );
  }
}
