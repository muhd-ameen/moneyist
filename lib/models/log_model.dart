class Log {
  int id;
  String title;
  DateTime date;
  String type;
  Log({this.title, this.date, this.type});
  Log.withId({this.id, this.title, this.date, this.type});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['id'] = id;
    map['title'] = title;
    map['date'] = date.toIso8601String();
    map['type'] = type;
    return map;
  }

  factory Log.fromMap(Map<String, dynamic> map) {
    return Log.withId(
        id: map['id'],
        title: map['title'],
        date: DateTime.parse(map['date']),
        type: map['type']);
  }
}
