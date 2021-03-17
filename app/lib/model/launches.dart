import 'dart:convert';

class Launch {
  Launch(
      {this.isFavorite,
      this.name,
      this.dateUtc,
      this.dateUnix,
      this.id,
      this.formattedDate});

  bool isFavorite;
  String name;
  DateTime dateUtc;
  int dateUnix;
  String id;
  String formattedDate;

  factory Launch.fromJson(Map<String, dynamic> json) => Launch(
      isFavorite: false,
      name: json["name"],
      dateUtc: DateTime.parse(json["date_utc"]),
      dateUnix: json["date_unix"],
      id: json["id"],
      formattedDate: json["formattedDate"]);

  Map<String, dynamic> toJson() => {
        "isFavorite": isFavorite,
        "name": name,
        "date_utc": dateUtc.toIso8601String(),
        "date_unix": dateUnix,
        "formattedDate": formattedDate,
        "id": id,
      };

  static List<Launch> launchFromJson(String str) =>
      List<Launch>.from(json.decode(str).map((x) => Launch.fromJson(x)));

  static String launchToJson(List<Launch> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}
