class Post {
  final String fnName;
  final String fnDescription;
  final String fnDatetime;
  final String fnThumb;
  final String fnGoal;
  final String fnMade;
  final String fnCoinSum;
  final String fnDocID;

  Post.fromMap(Map<String, dynamic> map, this.fnDocID)
      : fnName = map['title'],
        fnDescription = map['body'],
        fnDatetime = map['pub_date'],
        fnThumb = map['thumb'],
        fnGoal = map['target_amount'],
        fnMade = map['made'],
        fnCoinSum = map['coinSum'];
  // fnDocID = map['docID'];

  // Post.fromJson(Map<String, dynamic> map)
  //     : fnName = map['title'],
  //       fnDescription = map['body'],
  //       fnDatetime = map['pub_date'],
  //       fnThumb = map['thumb'],
  //       fnGoal = map['target_amount'],
  //       fnMade = map['made'],
  //       fnCoinSum = map['coinSum'];
  //       fndocID = map['docID'];

  @override
  String toString() => "Post<$fnName:$fnDescription>";
}
