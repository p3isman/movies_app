class Movies {
  List<Movie> items = [];
  Movies();

  // Generate a movie from each item in the JSON and add it to the list
  Movies.fromJson(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final movie = new Movie.fromJson(item);
      items.add(movie);
    }
  }
}

// This class let's us create a movie object from a JSON, by extracting all its keys and converting them into variables
class Movie {
  String uniqueId;

  bool _adult;
  String _backdropPath;
  List<int> _genreIds;
  int _id;
  String _originalLanguage;
  String _originalTitle;
  String _overview;
  double _popularity;
  String _posterPath;
  String _releaseDate;
  String _title;
  bool _video;
  double _voteAverage;
  int _voteCount;

  bool get adult => _adult;
  String get backdropPath => _backdropPath;
  List<int> get genreIds => _genreIds;
  int get id => _id;
  String get originalLanguage => _originalLanguage;
  String get originalTitle => _originalTitle;
  String get overview => _overview;
  double get popularity => _popularity;
  String get posterPath => _posterPath;
  String get releaseDate => _releaseDate;
  String get title => _title;
  bool get video => _video;
  double get voteAverage => _voteAverage;
  int get voteCount => _voteCount;

  Movie(
      {bool adult,
      String backdropPath,
      List<int> genreIds,
      int id,
      String originalLanguage,
      String originalTitle,
      String overview,
      double popularity,
      String posterPath,
      String releaseDate,
      String title,
      bool video,
      double voteAverage,
      int voteCount}) {
    _adult = adult;
    _backdropPath = backdropPath;
    _genreIds = genreIds;
    _id = id;
    _originalLanguage = originalLanguage;
    _originalTitle = originalTitle;
    _overview = overview;
    _popularity = popularity;
    _posterPath = posterPath;
    _releaseDate = releaseDate;
    _title = title;
    _video = video;
    _voteAverage = voteAverage;
    _voteCount = voteCount;
  }

  Movie.fromJson(dynamic json) {
    _adult = json["adult"];
    _backdropPath = json["backdrop_path"];
    _genreIds = json["genre_ids"].cast<int>();
    _id = json["id"];
    _originalLanguage = json["original_language"];
    _originalTitle = json["original_title"];
    _overview = json["overview"];
    _popularity = json["popularity"] / 1;
    _posterPath = json["poster_path"];
    _releaseDate = json["release_date"];
    _title = json["title"];
    _video = json["video"];
    _voteAverage = json["vote_average"] / 1;
    _voteCount = json["vote_count"];
  }

  // Get poster URL
  String getPoster() {
    return posterPath == null
        ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/No_image_available_500_x_500.svg/1024px-No_image_available_500_x_500.svg.png'
        : 'https://image.tmdb.org/t/p/w500/$posterPath';
  }

  String getBackdrop() {
    return backdropPath == null
        ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/No_image_available_500_x_500.svg/1024px-No_image_available_500_x_500.svg.png'
        : 'https://image.tmdb.org/t/p/w500/$backdropPath';
  }
}
