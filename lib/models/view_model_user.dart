// To parse this JSON data, do
//
//     final userLoginData = userLoginDataFromJson(jsonString);

import 'dart:convert';

UserLoginData userDataFromJson(String str) => UserLoginData.fromJson(json.decode(str));

String userLoginDataToJson(UserLoginData data) => json.encode(data.toJson());

class UserLoginData {
  ViewModelUser user;
  String otp;

  UserLoginData({
    required this.user,
    required this.otp,
  });

  factory UserLoginData.fromJson(Map<String, dynamic> json) => UserLoginData(
        user: ViewModelUser.fromJson(json["user"]),
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "otp": otp,
      };
}

class ViewModelUser {
  int id;
  String username;
  String email;
  String provider;
  dynamic resetPasswordToken;
  dynamic confirmationToken;
  bool confirmed;
  bool blocked;
  String firstName;
  String lastName;
  String gender;
  String nationality;
  String phoneNumber;

  ViewModelUser({
    required this.id,
    required this.username,
    required this.email,
    required this.provider,
    required this.resetPasswordToken,
    required this.confirmationToken,
    required this.confirmed,
    required this.blocked,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.nationality,
    required this.phoneNumber,
  });

  factory ViewModelUser.fromJson(Map<String, dynamic> json) => ViewModelUser(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        provider: json["provider"],
        resetPasswordToken: json["resetPasswordToken"],
        confirmationToken: json["confirmationToken"],
        confirmed: json["confirmed"],
        blocked: json["blocked"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        nationality: json["nationality"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "provider": provider,
        "resetPasswordToken": resetPasswordToken,
        "confirmationToken": confirmationToken,
        "confirmed": confirmed,
        "blocked": blocked,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "nationality": nationality,
        "phoneNumber": phoneNumber,
      };
}
