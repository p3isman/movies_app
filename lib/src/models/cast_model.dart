class Cast {
  int id;
  List<Actor> items;

  Cast({this.id, this.items});

  Cast.fromJson(dynamic json) {
    id = json["id"];
    if (json["cast"] != null) {
      items = [];
      json["cast"].forEach((v) {
        items.add(Actor.fromJson(v));
      });
    }
  }
}

class Actor {
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;

  Actor(
      {this.adult,
      this.gender,
      this.id,
      this.knownForDepartment,
      this.name,
      this.originalName,
      this.popularity,
      this.profilePath,
      this.castId,
      this.character,
      this.creditId,
      this.order});

  Actor.fromJson(dynamic json) {
    adult = json["adult"];
    gender = json["gender"];
    id = json["id"];
    knownForDepartment = json["known_for_department"];
    name = json["name"];
    originalName = json["original_name"];
    popularity = json["popularity"];
    profilePath = json["profile_path"];
    castId = json["cast_id"];
    character = json["character"];
    creditId = json["credit_id"];
    order = json["order"];
  }

  String getImageUrl() {
    return profilePath == null
        ? 'https://www.pmc-kollum.nl/wp-content/uploads/2017/05/no_avatar.jpg'
        : 'https://image.tmdb.org/t/p/w500/$profilePath';
  }
}
