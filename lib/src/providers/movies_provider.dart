import 'dart:async';
import 'dart:convert';

import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/models/cast_model.dart';
import 'package:http/http.dart' as http;

// Class to get the movie list
class MoviesProvider {
  String _apiKey = '1bfd43a586941889a6978e801fd2753d';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _pageNumber = 0;
  bool _isLoading = false;

  List<Movie> _popularMovies = [];
  // New stream controller with broadcast, to allow multiple listeners
  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  // Close all streams when not used
  void disposeStreams() {
    _popularStreamController?.close();
  }

  // Getters for sink and stream
  Function(List<Movie>) get popularAddToSink =>
      _popularStreamController.sink.add;
  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

  // Get movie list from HTTP request
  Future<List<Movie>> processUrl(Uri url) async {
    // HTTP request
    final response = await http.get(url);

    // From string to JSON
    final decodedData = json.decode(response.body);

    // Create movie list with constructor
    final movies = new Movies.fromJson(decodedData['results']);

    // Movie list
    return movies.items;
  }

  Future<List<Movie>> getInTheatres() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    return await processUrl(url);
  }

  // Called each time we want to obtain new popular movies
  Future<List<Movie>> getPopular() async {
    // Avoid multiple simultaneous calls
    if (_isLoading) return [];

    _isLoading = true;

    _pageNumber++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _pageNumber.toString(),
    });

    final resp = await processUrl(url);

    // Add to list
    _popularMovies.addAll(resp);

    // Add list to sink
    popularAddToSink(_popularMovies);

    _isLoading = false;

    return resp;
  }

  Future<List<Actor>> getCast(String id) async {
    final url = Uri.https(_url, '3/movie/$id/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    final response = await http.get(url);

    final decodedData = json.decode(response.body);

    final cast = new Cast.fromJson(decodedData);

    return cast.items;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query' : query,
    });

    return await processUrl(url);
  }
}
