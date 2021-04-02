import 'package:movies/src/models/movie_model.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

// Class to make the http request
class MoviesProvider {
  String _apiKey = '1bfd43a586941889a6978e801fd2753d';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  // Method to return a list of movies
  Future<List<Movie>> getInTheatres() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    // HTTP request
    final response = await http.get(url);
    // From string to JSON
    final decodedData = json.decode(response.body);

    final movies = new Movies.fromJson(decodedData['results']);
    return movies.items;
  }
}
