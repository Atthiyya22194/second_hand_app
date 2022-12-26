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

    int? id;
    String? fullName;
    String? email;
    String? password;
    int? phoneNumber;
    String? address;
    dynamic imageUrl;
    String? city;
    DateTime? createdAt;
    DateTime? updatedAt;

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
        "id": id ?? "No user information given",
        "full_name": fullName ?? "No user information given",
        "email": email ?? "No user information given",
        "password": password ?? "No user information given",
        "phone_number": phoneNumber ?? "No user information given",
        "address": address ?? "No user information given",
        "image_url": imageUrl,
        "city": city ?? "No user information given",
        "createdAt": createdAt ?? "No user information given",
        "updatedAt": updatedAt ?? "No user information given",
    };
}
