class Movie {
  final String title;
  final String body;
  // final String keyword;
  final String thumbnail;
  // ignore: non_constant_identifier_names
  final String target_amount;
  // final String percentage;
  final bool like;

  Movie.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        body = map['body'],
        // keyword = map['keyword'],
        thumbnail = map['thumbnail'],
        target_amount = map['target_amount'],
        // percentage = map['percentage'],
        like = map['like'];

  Movie.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        body = json['body'],
        // keyword = json['keyword'],
        thumbnail = json['thumbnail'],
        target_amount = json['target_amount'],
        // percentage = json['percentage'],
        like = json['like'];

  @override
  String toString() => "Movie<$title:$body>";
}
