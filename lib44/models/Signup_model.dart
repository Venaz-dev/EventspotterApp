import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    Welcome({
        required this.success,
        required this.data,
         required this.token,
       required this.message,
    });

    bool success;
    Data data;
    String token;
    String message;

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        token: json["token"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "token": token,
        "message": message,
    };
}

class Data {
    Data({
       required this.name,
      required  this.phoneNumber,
       required this.email,
       required this.ipAddress,
       required this.updatedAt,
       required this.createdAt,
       required this.id,
    });

    String name;
    String phoneNumber;
    String email;
    String ipAddress;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        ipAddress: json["ip_address"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "phone_number": phoneNumber,
        "email": email,
        "ip_address": ipAddress,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
