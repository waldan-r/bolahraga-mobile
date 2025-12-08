// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
    String id;
    String name;
    int price;
    String description;
    String? thumbnail;
    int stock;
    String category;
    bool isFeatured;
    int? userId;

    Product({
        required this.id,
        required this.name,
        required this.price,
        required this.description,
        this.thumbnail,
        required this.stock,
        required this.category,
        required this.isFeatured,
        this.userId,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] is String ? json["id"] : json["id"].toString(), // UUID bisa jadi string atau objek, pastikan string
        name: json["name"],
        price: json["price"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        stock: json["stock"],
        category: json["category"],
        isFeatured: json["is_featured"],
        // user_id bisa null jika user belum login atau diatur di Django
        userId: json["user_id"] != null ? int.tryParse(json["user_id"].toString()) : null,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "thumbnail": thumbnail,
        "stock": stock,
        "category": category,
        "is_featured": isFeatured,
        "user_id": userId,
    };
}