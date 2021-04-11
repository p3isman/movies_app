import 'package:flutter/material.dart';

import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/widgets/actors_list.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      // Same as ListView but allows different types of children
      body: CustomScrollView(
        slivers: [
          _appBar(movie),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10.0),
              _moviePoster(context, movie),
              _description(context, movie),
              _cast(movie),
            ]),
          )
        ],
      ),
    );
  }

  Widget _appBar(Movie movie) {
    return SliverAppBar(
      elevation: 50.0,
      expandedHeight: 200.0,
      pinned: true,
      floating: false,
      // Space changed when scrolled
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0, shadows: [
            BoxShadow(blurRadius: 10.0, spreadRadius: 1.0),
          ]),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image: NetworkImage(movie.getBackdrop()),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _moviePoster(BuildContext context, Movie movie) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: Row(
        children: [
          // Poster image
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image(
              image: NetworkImage(movie.getPoster()),
              height: 150.0,
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title,
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.ellipsis),
                SizedBox(height: 5.0),
                Text(movie.originalTitle,
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis),
                SizedBox(height: 5.0),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    SizedBox(width: 5.0),
                    Text(movie.voteAverage.toString()),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _description(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Text(
        movie.overview,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }

  Widget _cast(Movie movie) {
    final moviesProvider = new MoviesProvider();
    final id = movie.id.toString();

    return FutureBuilder(
      future: moviesProvider.getCast(id),
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return ActorsList(cast: snapshot.data);
        else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
