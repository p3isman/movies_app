import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/widgets/actors_list.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/cast_model.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie? movie = ModalRoute.of(context)!.settings.arguments as Movie?;

    return Scaffold(
      // Same as ListView but allows different types of children
      body: CustomScrollView(
        slivers: [
          _AppBar(movie: movie),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10.0),
              _MoviePoster(context: context, movie: movie),
              _Description(context: context, movie: movie),
              _Cast(movie: movie),
            ]),
          )
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 50.0,
      expandedHeight: 200.0,
      pinned: true,
      floating: false,
      // Space changed when scrolled
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie!.title!,
          style: TextStyle(color: Colors.white, fontSize: 16.0, shadows: [
            BoxShadow(blurRadius: 10.0, spreadRadius: 1.0),
          ]),
        ),
        background: FadeInImage.memoryNetwork(
          image: movie!.getBackdropUrl(),
          placeholder: kTransparentImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster({
    Key? key,
    required this.context,
    required this.movie,
  }) : super(key: key);

  final BuildContext context;
  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: Row(
        children: [
          // Poster image
          Hero(
            tag: movie!.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                image: NetworkImage(movie!.getPosterUrl()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie!.title!,
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis),
                SizedBox(height: 5.0),
                Text(movie!.originalTitle!,
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis),
                SizedBox(height: 5.0),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    SizedBox(width: 5.0),
                    Text(movie!.voteAverage.toString()),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    Key? key,
    required this.context,
    required this.movie,
  }) : super(key: key);

  final BuildContext context;
  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Text(
        movie!.overview!,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}

class _Cast extends StatelessWidget {
  const _Cast({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    final moviesProvider = new MoviesProvider();
    final id = movie!.id.toString();

    return FutureBuilder(
      future: moviesProvider.getCast(id),
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return ActorsList(cast: snapshot.data as List<Actor>);
        else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
