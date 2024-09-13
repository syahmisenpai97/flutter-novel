import 'package:kacs/models/view_model_user.dart';

class ViewModelValidateOtp {
  ViewModelUser user;
  String otp;

  ViewModelValidateOtp({
    required this.user,
    required this.otp,
  });

  factory ViewModelValidateOtp.fromJson(Map<String, dynamic> json) => ViewModelValidateOtp(
        user: ViewModelUser.fromJson(json["user"]),
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "otp": otp,
      };
}
