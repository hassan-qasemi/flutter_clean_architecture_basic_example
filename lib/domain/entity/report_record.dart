class ReportRecord {
  String? id;
  String? title;
  String? desc;
  String? date;
  String? place;

  ReportRecord();

  ReportRecord.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    desc = json["desc"];
    date = json["date"];
    place = json["place"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "desc": desc,
        "date": date,
        "place": place,
      };
}
