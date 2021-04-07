import 'package:flutter/material.dart';
import 'package:movies/src/providers/movies_provider.dart';

import 'package:movies/src/widgets/card_swiper.dart';
import 'package:movies/src/widgets/movies_horizontal.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {

    moviesProvider.getPopular();

    return Scaffold(
      appBar: AppBar(
        title: Text('Películas en cines'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _cardSwiper(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _cardSwiper() {
    return FutureBuilder(
      // Movie list
      future: moviesProvider.getInTheatres(),
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return CardSwiper(movieList: snapshot.data);
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

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(left: 15.0),
              child: Text('Populares', style: Theme.of(context).textTheme.subtitle1)),
          SizedBox(height: 15.0),
          // Build movie PageView from the moviesProvider's stream
          StreamBuilder(
              stream: moviesProvider.popularStream,
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return MoviesHorizontal(movies: snapshot.data, nextPage: moviesProvider.getPopular);
                else
                  return Center(child: CircularProgressIndicator());
              }),
        ],
      ),
    );
  }
}
