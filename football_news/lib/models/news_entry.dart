// football_news/lib/models/news_entry.dart

import 'dart:convert';

// Fungsi untuk mengkonversi list JSON menjadi List<NewsEntry>
List<NewsEntry> newsEntryFromJson(String str) => List<NewsEntry>.from(
    json.decode(str).map((x) => NewsEntry.fromJson(x)));

// Fungsi untuk mengkonversi List<NewsEntry> menjadi string JSON
String newsEntryToJson(List<NewsEntry> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsEntry {
  NewsEntry({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.thumbnail,
    required this.newsViews,
    required this.createdAt,
    required this.isFeatured,
    required this.userId,
  });

  String id;
  String title;
  String content;
  String category;
  String thumbnail;
  int newsViews;
  DateTime createdAt;
  bool isFeatured;
  int userId;

  factory NewsEntry.fromJson(Map<String, dynamic> json) => NewsEntry(
        id: json["id"], 
        title: json["title"],
        content: json["content"],
        category: json["category"],
        thumbnail: json["thumbnail"],
        newsViews: json["news_views"],
        createdAt: DateTime.parse(json["created_at"]),
        isFeatured: json["is_featured"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "category": category,
        "thumbnail": thumbnail,
        "news_views": newsViews,
        "created_at": createdAt.toIso8601String(),
        "is_featured": isFeatured,
        "user_id": userId,
      };
}