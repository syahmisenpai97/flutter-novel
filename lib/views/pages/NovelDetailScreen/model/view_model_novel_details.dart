// To parse this JSON data, do
//
//     final novelDetailsData = novelDetailsDataFromJson(jsonString);

import 'dart:convert';

NovelDetailsData novelDetailsDataFromJson(String str) => NovelDetailsData.fromJson(json.decode(str));

String novelDetailsDataToJson(NovelDetailsData data) => json.encode(data.toJson());

class NovelDetailsData {
  ViewModelNovelDetails data;

  NovelDetailsData({
    required this.data,
  });

  factory NovelDetailsData.fromJson(Map<String, dynamic> json) => NovelDetailsData(
        data: ViewModelNovelDetails.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class ViewModelNovelDetails {
  int id;
  String title;
  String author;
  DateTime publication;
  String genre;
  int ratings;
  String summary;
  Cover cover;

  ViewModelNovelDetails({
    required this.id,
    required this.title,
    required this.author,
    required this.publication,
    required this.genre,
    required this.ratings,
    required this.summary,
    required this.cover,
  });

  factory ViewModelNovelDetails.fromJson(Map<String, dynamic> json) => ViewModelNovelDetails(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        publication: DateTime.parse(json["publication"]),
        genre: json["genre"],
        ratings: json["ratings"],
        summary: json["summary"],
        cover: Cover.fromJson(json["cover"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
        "publication": publication.toIso8601String(),
        "genre": genre,
        "ratings": ratings,
        "summary": summary,
        "cover": cover.toJson(),
      };
}

class Cover {
  int id;
  String name;
  dynamic alternativeText;
  dynamic caption;
  dynamic width;
  dynamic height;
  Formats formats;
  String hash;
  String ext;
  String mime;
  double size;
  String url;
  dynamic previewUrl;
  String provider;
  dynamic providerMetadata;
  String folderPath;

  Cover({
    required this.id,
    required this.name,
    required this.alternativeText,
    required this.caption,
    required this.width,
    required this.height,
    required this.formats,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    required this.previewUrl,
    required this.provider,
    required this.providerMetadata,
    required this.folderPath,
  });

  factory Cover.fromJson(Map<String, dynamic> json) => Cover(
        id: json["id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        width: json["width"],
        height: json["height"],
        formats: Formats.fromJson(json["formats"]),
        hash: json["hash"],
        ext: json["ext"],
        mime: json["mime"],
        size: json["size"]?.toDouble(),
        url: json["url"],
        previewUrl: json["previewUrl"],
        provider: json["provider"],
        providerMetadata: json["provider_metadata"],
        folderPath: json["folderPath"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "alternativeText": alternativeText,
        "caption": caption,
        "width": width,
        "height": height.toIso8601String(),
        "formats": formats.toJson(),
        "hash": hash,
        "ext": ext,
        "mime": mime,
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": provider,
        "provider_metadata": providerMetadata,
        "folderPath": folderPath,
      };
}

class Formats {
  Medium? small;
  Medium? medium;
  Thumbnail? thumbnail;

  Formats({
    this.small,
    this.medium,
    this.thumbnail,
  });

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        small: json["small"] != null ? Medium.fromJson(json["small"]) : null,
        medium: json["medium"] != null ? Medium.fromJson(json["medium"]) : null,
        thumbnail: json["thumbnail"] != null ? Thumbnail.fromJson(json["thumbnail"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "small": small?.toJson(),
        "medium": medium?.toJson(),
        "thumbnail": thumbnail?.toJson(),
      };
}

class Medium {
  String ext;
  String url;
  String hash;
  String mime;
  String name;
  dynamic path;
  double size;
  int width;
  int height;
  int sizeInBytes;

  Medium({
    required this.ext,
    required this.url,
    required this.hash,
    required this.mime,
    required this.name,
    required this.path,
    required this.size,
    required this.width,
    required this.height,
    required this.sizeInBytes,
  });

  factory Medium.fromJson(Map<String, dynamic> json) => Medium(
        ext: json["ext"],
        url: json["url"],
        hash: json["hash"],
        mime: json["mime"],
        name: json["name"],
        path: json["path"],
        size: json["size"]?.toDouble(),
        width: json["width"],
        height: json["height"],
        sizeInBytes: json["sizeInBytes"],
      );

  Map<String, dynamic> toJson() => {
        "ext": ext,
        "url": url,
        "hash": hash,
        "mime": mime,
        "name": name,
        "path": path,
        "size": size,
        "width": width,
        "height": height,
        "sizeInBytes": sizeInBytes,
      };
}

class Thumbnail {
  String ext;
  String url;
  String hash;
  String mime;
  String name;
  dynamic path;
  double size;
  int width;
  int height;
  DateTime sizeInBytes;

  Thumbnail({
    required this.ext,
    required this.url,
    required this.hash,
    required this.mime,
    required this.name,
    required this.path,
    required this.size,
    required this.width,
    required this.height,
    required this.sizeInBytes,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        ext: json["ext"],
        url: json["url"],
        hash: json["hash"],
        mime: json["mime"],
        name: json["name"],
        path: json["path"],
        size: json["size"]?.toDouble(),
        width: json["width"],
        height: json["height"],
        sizeInBytes: DateTime.parse(json["sizeInBytes"]),
      );

  Map<String, dynamic> toJson() => {
        "ext": ext,
        "url": url,
        "hash": hash,
        "mime": mime,
        "name": name,
        "path": path,
        "size": size,
        "width": width,
        "height": height,
        "sizeInBytes": sizeInBytes.toIso8601String(),
      };
}
