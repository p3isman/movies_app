import 'package:movies/src/models/movie_model.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

// Class to get the movie list
class MoviesProvider {
  String _apiKey = '1bfd43a586941889a6978e801fd2753d';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  // Get movie list from HTTP request
  Future<List<Movie>> getInTheatres() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    // HTTP request
    final response = await http.get(url);

    // From string to JSON
    final decodedData = json.decode(response.body);

    // Create movie list with constructor
    final movies = new Movies.fromJson(decodedData['results']);

    // Movie list
    return movies.items;
  }
}
