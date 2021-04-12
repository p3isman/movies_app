import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {

  final moviesProvider = new MoviesProvider();
  String selection;

  @override
  String searchFieldLabel = 'Buscar...';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () => query = ''),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) return Container();

    return FutureBuilder(
        future: moviesProvider.searchMovie(query),
        builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.hasData) {
            final movies = snapshot.data;

            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, i) {
                movies[i].uniqueId = UniqueKey().toString();

                return ListTile(
                  leading: Hero(
                    tag: movies[i].uniqueId,
                    child: FadeInImage(
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      image: NetworkImage(movies[i].getPoster()),
                      height: 50.0,
                    ),
                  ),
                  title: Text(movies[i].title),
                  onTap: () {
                    close(context, null);
                    Navigator.pushNamed(context, 'details', arguments: movies[i]);
                  },
                );
              },
            );
          }
          else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return Container();

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, i) {
              movies[i].uniqueId = UniqueKey().toString();

              return ListTile(
                leading: Hero(
                  tag: movies[i].uniqueId,
                  child: FadeInImage(
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    image: NetworkImage(movies[i].getPoster()),
                    height: 50.0,
                  ),
                ),
                title: Text(movies[i].title),
                onTap: () {
                  Navigator.pushNamed(context, 'details', arguments: movies[i]);
                },
              );
            },
          );
        }
        else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }
}