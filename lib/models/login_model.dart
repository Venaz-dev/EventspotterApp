// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.user,
    required this.token,
    required this.message,
  });

  User user;
  String token;
  String message;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        user: User.fromJson(json["user"]),
        token: json["token"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
        "message": message,
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.ipAddress,
    this.latLng,
    required this.isOnline,
    required this.emailVerifiedAt,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.profileImage,
    required this.mobileIsPrivate,
    required this.avatar,
    required this.messengerColor,
    required this.darkMode,
    required this.activeStatus,
  });

  int id;
  String name;
  String email;
  String ipAddress;
  dynamic latLng;
  String isOnline;
  dynamic emailVerifiedAt;
  String phoneNumber;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic profileImage;
  String mobileIsPrivate;
  String avatar;
  String messengerColor;
  String darkMode;
  String activeStatus;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        ipAddress: json["ip_address"],
        latLng: json["lat_lng"],
        isOnline: json["is_online"],
        emailVerifiedAt: json["email_verified_at"],
        phoneNumber: json["phone_number"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        profileImage: json["profile_image"],
        mobileIsPrivate: json["mobile_is_private"],
        avatar: json["avatar"],
        messengerColor: json["messenger_color"],
        darkMode: json["dark_mode"],
        activeStatus: json["active_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "ip_address": ipAddress,
        "lat_lng": latLng,
        "is_online": isOnline,
        "email_verified_at": emailVerifiedAt,
        "phone_number": phoneNumber,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "profile_image": profileImage,
        "mobile_is_private": mobileIsPrivate,
        "avatar": avatar,
        "messenger_color": messengerColor,
        "dark_mode": darkMode,
        "active_status": activeStatus,
      };
}
