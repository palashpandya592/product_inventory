// To parse this JSON data, do
//
//     final productUpdateModel = productUpdateModelFromJson(jsonString);

import 'dart:convert';

ProductUpdateModel productUpdateModelFromJson(String str) =>
    ProductUpdateModel.fromJson(json.decode(str));

String productUpdateModelToJson(ProductUpdateModel data) =>
    json.encode(data.toJson());

class ProductUpdateModel {
  ProductUpdateModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory ProductUpdateModel.fromJson(Map<String, dynamic> json) =>
      ProductUpdateModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.name,
    this.mrp,
    this.selling,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.img,
  });

  int? id;
  String? name;
  String? mrp;
  String? selling;
  String? description;
  dynamic image;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic img;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        mrp: json["mrp"],
        selling: json["selling"],
        description: json["description"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mrp": mrp,
        "selling": selling,
        "description": description,
        "image": image,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "img": img,
      };
}
