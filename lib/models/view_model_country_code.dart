// To parse this JSON data, do
//
//     final countryCodeData = countryCodeDataFromJson(jsonString);

import 'dart:convert';

CountryCodeData countryCodeDataFromJson(String str) => CountryCodeData.fromJson(json.decode(str));

String countryCodeDataToJson(CountryCodeData data) => json.encode(data.toJson());

class CountryCodeData {
  List<ViewModelCountryCode> data;

  CountryCodeData({
    required this.data,
  });

  factory CountryCodeData.fromJson(Map<String, dynamic> json) => CountryCodeData(
        data: List<ViewModelCountryCode>.from(json["data"].map((x) => ViewModelCountryCode.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ViewModelCountryCode {
  String name;
  String dialCode;
  String flag;
  String code;

  ViewModelCountryCode({
    required this.name,
    required this.dialCode,
    required this.flag,
    required this.code,
  });

  factory ViewModelCountryCode.fromJson(Map<String, dynamic> json) => ViewModelCountryCode(
        name: json["name"],
        dialCode: json["dialCode"],
        flag: json["flag"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "dialCode": dialCode,
        "flag": flag,
        "code": code,
      };
}
