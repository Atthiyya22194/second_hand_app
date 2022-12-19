import 'dart:convert';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
    UserResponse({
        required this.id,
        required this.fullName,
        required this.email,
        required this.password,
        required this.phoneNumber,
        required this.address,
        required this.imageUrl,
        required this.city,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String fullName;
    String email;
    String password;
    int phoneNumber;
    String address;
    dynamic imageUrl;
    String city;
    DateTime createdAt;
    DateTime updatedAt;

    factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        id: json["id"],
        fullName: json["full_name"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        imageUrl: json["image_url"],
        city: json["city"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "email": email,
        "password": password,
        "phone_number": phoneNumber,
        "address": address,
        "image_url": imageUrl,
        "city": city,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
