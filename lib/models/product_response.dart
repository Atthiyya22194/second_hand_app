import 'dart:convert';

List<ProductResponse> productResponseFromJson(String str) =>
    List<ProductResponse>.from(
        json.decode(str).map((x) => ProductResponse.fromJson(x)));

String productResponseToJson(List<ProductResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductResponse {
  ProductResponse(
      {required this.id,
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
      required this.categories});

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
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
              json["Categories"].map((x) => Category.fromJson(x))));

  int basePrice;
  List<Category> categories;
  DateTime createdAt;
  String description;
  int id;
  String imageName;
  String imageUrl;
  String location;
  String name;
  String status;
  DateTime updatedAt;
  int userId;

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
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  int id;
  String name;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
