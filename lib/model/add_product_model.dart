// To parse this JSON data, do
//
//     final addProductModel = addProductModelFromJson(jsonString);

import 'dart:convert';

AddProductModel addProductModelFromJson(String str) =>
    AddProductModel.fromJson(json.decode(str));

String addProductModelToJson(AddProductModel data) =>
    json.encode(data.toJson());

class AddProductModel {
  AddProductModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  Data? data;

  factory AddProductModel.fromJson(Map<String, dynamic> json) =>
      AddProductModel(
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
    this.name,
    this.mrp,
    this.selling,
    this.description,
    this.image,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.img,
  });

  String? name;
  String? mrp;
  String? selling;
  String? description;
  dynamic image;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  dynamic img;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        mrp: json["mrp"],
        selling: json["selling"],
        description: json["description"],
        image: json["image"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "mrp": mrp,
        "selling": selling,
        "description": description,
        "image": image,
        "updated_at": updatedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "id": id,
        "img": img,
      };
}
