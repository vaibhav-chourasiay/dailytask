class Mytodo {
  int? id;
  String? title;
  String? des;
  String? cat;
  int? hours;
  DateTime? d;

  Mytodo({this.id, this.title, this.des, this.cat, this.hours, this.d});

  toMap() {
    return {
      "id": id,
      "title": title,
      "des": des,
      "cat": cat,
      "hours": hours,
      "d": d.toString(),
    };
  }
}
