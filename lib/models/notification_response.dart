import 'dart:convert';

List<NotificationResponse> notificationResponseFromJson(String str) =>
    List<NotificationResponse>.from(
        json.decode(str).map((x) => NotificationResponse.fromJson(x)));

String notificationResponseToJson(List<NotificationResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationResponse {
  NotificationResponse({
    required this.id,
    required this.productId,
    required this.productName,
    required this.basePrice,
    required this.bidPrice,
    required this.imageUrl,
    required this.transactionDate,
    required this.status,
    required this.sellerName,
    required this.buyerName,
    required this.receiverId,
    required this.read,
    required this.notificationType,
    required this.orderId,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
    required this.user,
  });

  int id;
  int productId;
  String productName;
  String basePrice;
  dynamic bidPrice;
  String imageUrl;
  dynamic transactionDate;
  String status;
  String sellerName;
  dynamic buyerName;
  int receiverId;
  bool read;
  String notificationType;
  int? orderId;
  DateTime createdAt;
  DateTime updatedAt;
  Product product;
  User user;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      NotificationResponse(
        id: json["id"],
        productId: json["product_id"],
        productName: json["product_name"],
        basePrice: json["base_price"],
        bidPrice: json["bid_price"],
        imageUrl: json["image_url"],
        transactionDate: json["transaction_date"],
        status: json["status"],
        sellerName: json["seller_name"],
        buyerName: json["buyer_name"],
        receiverId: json["receiver_id"],
        read: json["read"],
        notificationType: json["notification_type"],
        orderId: json["order_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        product: Product.fromJson(json["Product"]),
        user: User.fromJson(json["User"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "product_name": productName,
        "base_price": basePrice,
        "bid_price": bidPrice,
        "image_url": imageUrl,
        "transaction_date": transactionDate,
        "status": status,
        "seller_name": sellerName,
        "buyer_name": buyerName,
        "receiver_id": receiverId,
        "read": read,
        "notification_type": notificationType,
        "order_id": orderId ?? "null",
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "Product": product.toJson(),
        "User": user.toJson(),
      };
}

class Product {
  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
  dynamic imageUrl;
  String city;

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
        "city": city,
      };
}
