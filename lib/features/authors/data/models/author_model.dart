import 'dart:convert';

Author authorFromJson(String str) => Author.fromJson(json.decode(str));

String authorToJson(Author data) => json.encode(data.toJson());

class Author {
  final int id;
  final String name;
  final String lastname;
  final DateTime birthDate;

  Author({
    required this.id,
    required this.name,
    required this.lastname,
    required this.birthDate,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        name: json["name"],
        lastname: json["lastname"],
        birthDate: DateTime.parse(json["birthDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastname": lastname,
        "birthDate": birthDate.toIso8601String(),
      };
}
