// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

Book bookFromJson(String str) => Book.fromJson(json.decode(str));

String bookToJson(Book data) => json.encode(data.toJson());

class Book {
    final int id;
    final String title;
    final String literaryGenre;
    final DateTime publicationDate;
    final String language;

    Book({
        required this.id,
        required this.title,
        required this.literaryGenre,
        required this.publicationDate,
        required this.language,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
        title: json["title"],
        literaryGenre: json["literary_genre"],
        publicationDate: DateTime.parse(json["publication_date"]),
        language: json["language"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "literary_genre": literaryGenre,
        "publication_date": publicationDate.toIso8601String(),
        "language": language,
    };
}
