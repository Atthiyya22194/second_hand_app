import 'dart:convert';

List<ProductDetailResponse> productResponseFromJson(String str) =>
    List<ProductDetailResponse>.from(
        json.decode(str).map((x) => ProductDetailResponse.fromJson(x)));

String productResponseToJson(List<ProductDetailResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductDetailResponse {
  ProductDetailResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.basePrice,
    required this.imageUrl,
    required this.imageName,
    required this.location,
    required this.userId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.categories,
     this.user,
  });

  int id;
  String name;
  String description;
  int basePrice;
  String imageUrl;
  String imageName;
  String location;
  int userId;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  List<Category> categories;
  User? user;

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) =>
      ProductDetailResponse(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        basePrice: json["base_price"],
        imageUrl: json["image_url"],
        imageName: json["image_name"],
        location: json["location"],
        userId: json["user_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        categories: List<Category>.from(
            json["Categories"].map((x) => Category.fromJson(x))),
        user: User.fromJson(json["User"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "base_price": basePrice,
        "image_url": imageUrl,
        "image_name": imageName,
        "location": location,
        "user_id": userId,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "Categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "User": user?.toJson(),
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class User {
  User({
    this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.imageUrl,
    required this.city,
  });

  int? id;
  String? fullName;
  String email;
  String phoneNumber;
  String address;
  String imageUrl;
  String? city;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["full_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        imageUrl: json["image_url"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName ?? "No user information",
        "email": email,
        "phone_number": phoneNumber,
        "address": address,
        "image_url": imageUrl,
        "city": city ?? "No user information",
      };
}
