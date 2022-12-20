import 'dart:convert';

List<OrderResponse> orderResponseFromJson(String str) =>
    List<OrderResponse>.from(
        json.decode(str).map((x) => OrderResponse.fromJson(x)));

String orderResponseToJson(List<OrderResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderResponse {
  OrderResponse({
    required this.id,
    required this.productId,
    required this.buyerId,
    required this.price,
    required this.transactionDate,
    required this.productName,
    required this.basePrice,
    required this.imageProduct,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
    required this.user,
  });

  int id;
  int productId;
  int buyerId;
  int price;
  DateTime transactionDate;
  String productName;
  int basePrice;
  String imageProduct;
  String status;
  dynamic createdAt;
  dynamic updatedAt;
  Product product;
  User? user;

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        id: json["id"],
        productId: json["product_id"],
        buyerId: json["buyer_id"],
        price: json["price"],
        transactionDate: DateTime.parse(json["transaction_date"]),
        productName: json["product_name"],
        basePrice: json["base_price"],
        imageProduct: json["image_product"],
        status: json["status"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        product: Product.fromJson(json["Product"]),
        user: User.fromJson(json["User"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "buyer_id": buyerId,
        "price": price,
        "transaction_date": transactionDate.toIso8601String(),
        "product_name": productName,
        "base_price": basePrice,
        "image_product": imageProduct,
        "status": status,
        "createdAt": createdAt ?? "null",
        "updatedAt": updatedAt ?? "null",
        "Product": product.toJson(),
        "User": user?.toJson() ?? "No user information",
      };
}

class Product {
  Product({
    required this.name,
    required this.description,
    required this.basePrice,
    required this.imageUrl,
    required this.imageName,
    required this.location,
    required this.userId,
    required this.status,
    required this.user,
  });

  String name;
  String description;
  int basePrice;
  String imageUrl;
  String imageName;
  String location;
  int userId;
  String status;
  User? user;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        description: json["description"],
        basePrice: json["base_price"],
        imageUrl: json["image_url"],
        imageName: json["image_name"],
        location: json["location"],
        userId: json["user_id"],
        status: json["status"],
        user: User.fromJson(json["User"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "base_price": basePrice,
        "image_url": imageUrl,
        "image_name": imageName,
        "location": location,
        "user_id": userId,
        "status": status,
        "User": user?.toJson() ?? "No user information",
      };
}

class User {
  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.imageUrl,
    required this.city,
  });

  int id;
  String fullName;
  String email;
  String phoneNumber;
  String address;
  String? imageUrl;
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
        "full_name": fullName,
        "email": email,
        "phone_number": phoneNumber,
        "address": address,
        "image_url": imageUrl,
        "city": city ?? "No user information",
      };
}
