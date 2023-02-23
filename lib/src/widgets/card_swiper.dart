import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movieList;

  // Constructor
  CardSwiper({@required this.movieList});

  @override
  Widget build(BuildContext context) {
    // Get size of screen in pixels
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          movieList[index].uniqueId = UniqueKey().toString();

          return Hero(
            tag: movieList[index].uniqueId,
            child: Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'details',
                      arguments: movieList[index]),
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    image: NetworkImage(movieList[index].getPosterUrl()),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: movieList.length,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
      ),
    );
  }
}
