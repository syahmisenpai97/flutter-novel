// To parse this JSON data, do
//
//     final novelData = novelDataFromJson(jsonString);

import 'dart:convert';

NovelData novelDataFromJson(String str) => NovelData.fromJson(json.decode(str));

String novelDataToJson(NovelData data) => json.encode(data.toJson());

class NovelData {
  List<ViewModelNovel> data;

  NovelData({
    required this.data,
  });

  factory NovelData.fromJson(Map<String, dynamic> json) => NovelData(
        data: List<ViewModelNovel>.from(json["data"].map((x) => ViewModelNovel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ViewModelNovel {
  int id;
  String title;
  String author;
  DateTime publication;
  String genre;
  int ratings;
  String summary;
  ViewModelCover cover;

  ViewModelNovel({
    required this.id,
    required this.title,
    required this.author,
    required this.publication,
    required this.genre,
    required this.ratings,
    required this.summary,
    required this.cover,
  });

  factory ViewModelNovel.fromJson(Map<String, dynamic> json) => ViewModelNovel(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        publication: DateTime.parse(json["publication"]),
        genre: json["genre"],
        ratings: json["ratings"],
        summary: json["summary"],
        cover: ViewModelCover.fromJson(json["cover"]),
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

class ViewModelCover {
  int id;
  String name;
  dynamic alternativeText;
  dynamic caption;
  dynamic width;
  dynamic height;
  ViewModelFormats formats;
  String hash;
  Ext ext;
  Mime mime;
  double size;
  String url;
  dynamic previewUrl;
  Provider provider;
  dynamic providerMetadata;
  FolderPath folderPath;

  ViewModelCover({
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

  factory ViewModelCover.fromJson(Map<String, dynamic> json) => ViewModelCover(
        id: json["id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        width: json["width"],
        height: json["height"],
        formats: ViewModelFormats.fromJson(json["formats"]),
        hash: json["hash"],
        ext: extValues.map[json["ext"]]!,
        mime: mimeValues.map[json["mime"]]!,
        size: json["size"]?.toDouble(),
        url: json["url"],
        previewUrl: json["previewUrl"],
        provider: providerValues.map[json["provider"]]!,
        providerMetadata: json["provider_metadata"],
        folderPath: folderPathValues.map[json["folderPath"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "alternativeText": alternativeText,
        "caption": caption,
        "width": width,
        "height": height,
        "formats": formats.toJson(),
        "hash": hash,
        "ext": extValues.reverse[ext],
        "mime": mimeValues.reverse[mime],
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": providerValues.reverse[provider],
        "provider_metadata": providerMetadata,
        "folderPath": folderPathValues.reverse[folderPath],
      };
}

enum Ext { JPEG, JPG }

final extValues = EnumValues({".jpeg": Ext.JPEG, ".jpg": Ext.JPG});

enum FolderPath { EMPTY }

final folderPathValues = EnumValues({"/": FolderPath.EMPTY});

class ViewModelFormats {
  ViewModelSmall small;
  ViewModelSmall? medium;
  ViewModelThumbnail thumbnail;
  ViewModelLarge? large;

  ViewModelFormats({
    required this.small,
    this.medium,
    required this.thumbnail,
    this.large,
  });

  factory ViewModelFormats.fromJson(Map<String, dynamic> json) => ViewModelFormats(
        small: ViewModelSmall.fromJson(json["small"]),
        medium: json["medium"] == null ? null : ViewModelSmall.fromJson(json["medium"]),
        thumbnail: ViewModelThumbnail.fromJson(json["thumbnail"]),
        large: json["large"] == null ? null : ViewModelLarge.fromJson(json["large"]),
      );

  Map<String, dynamic> toJson() => {
        "small": small.toJson(),
        "medium": medium?.toJson(),
        "thumbnail": thumbnail.toJson(),
        "large": large?.toJson(),
      };
}

class ViewModelLarge {
  Ext ext;
  String url;
  String hash;
  Mime mime;
  String name;
  dynamic path;
  double size;
  int width;
  DateTime height;
  int sizeInBytes;

  ViewModelLarge({
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

  factory ViewModelLarge.fromJson(Map<String, dynamic> json) => ViewModelLarge(
        ext: extValues.map[json["ext"]]!,
        url: json["url"],
        hash: json["hash"],
        mime: mimeValues.map[json["mime"]]!,
        name: json["name"],
        path: json["path"],
        size: json["size"]?.toDouble(),
        width: json["width"],
        height: DateTime.parse(json["height"]),
        sizeInBytes: json["sizeInBytes"],
      );

  Map<String, dynamic> toJson() => {
        "ext": extValues.reverse[ext],
        "url": url,
        "hash": hash,
        "mime": mimeValues.reverse[mime],
        "name": name,
        "path": path,
        "size": size,
        "width": width,
        "height": height.toIso8601String(),
        "sizeInBytes": sizeInBytes,
      };
}

enum Mime { IMAGE_JPEG }

final mimeValues = EnumValues({"image/jpeg": Mime.IMAGE_JPEG});

class ViewModelSmall {
  Ext ext;
  String url;
  String hash;
  Mime mime;
  String name;
  dynamic path;
  double size;
  int width;
  int height;
  int sizeInBytes;

  ViewModelSmall({
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

  factory ViewModelSmall.fromJson(Map<String, dynamic> json) => ViewModelSmall(
        ext: extValues.map[json["ext"]]!,
        url: json["url"],
        hash: json["hash"],
        mime: mimeValues.map[json["mime"]]!,
        name: json["name"],
        path: json["path"],
        size: json["size"]?.toDouble(),
        width: json["width"],
        height: json["height"],
        sizeInBytes: json["sizeInBytes"],
      );

  Map<String, dynamic> toJson() => {
        "ext": extValues.reverse[ext],
        "url": url,
        "hash": hash,
        "mime": mimeValues.reverse[mime],
        "name": name,
        "path": path,
        "size": size,
        "width": width,
        "height": height,
        "sizeInBytes": sizeInBytes,
      };
}

class ViewModelThumbnail {
  Ext ext;
  String url;
  String hash;
  Mime mime;
  String name;
  dynamic path;
  double size;
  int width;
  int height;
  DateTime sizeInBytes;

  ViewModelThumbnail({
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

  factory ViewModelThumbnail.fromJson(Map<String, dynamic> json) => ViewModelThumbnail(
        ext: extValues.map[json["ext"]]!,
        url: json["url"],
        hash: json["hash"],
        mime: mimeValues.map[json["mime"]]!,
        name: json["name"],
        path: json["path"],
        size: json["size"]?.toDouble(),
        width: json["width"],
        height: json["height"],
        sizeInBytes: DateTime.parse(json["sizeInBytes"]),
      );

  Map<String, dynamic> toJson() => {
        "ext": extValues.reverse[ext],
        "url": url,
        "hash": hash,
        "mime": mimeValues.reverse[mime],
        "name": name,
        "path": path,
        "size": size,
        "width": width,
        "height": height,
        "sizeInBytes": sizeInBytes.toIso8601String(),
      };
}

enum Provider { LOCAL }

final providerValues = EnumValues({"local": Provider.LOCAL});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
