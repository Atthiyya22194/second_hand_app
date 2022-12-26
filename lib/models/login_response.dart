import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.accessToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        accessToken: json["access_token"],
      );

  String accessToken;
  String email;
  int id;
  String name;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "access_token": accessToken,
      };
}
