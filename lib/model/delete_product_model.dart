// To parse this JSON data, do
//
//     final deleteProductModel = deleteProductModelFromJson(jsonString);

import 'dart:convert';

DeleteProductModel deleteProductModelFromJson(String str) =>
    DeleteProductModel.fromJson(json.decode(str));

String deleteProductModelToJson(DeleteProductModel data) =>
    json.encode(data.toJson());

class DeleteProductModel {
  DeleteProductModel({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory DeleteProductModel.fromJson(Map<String, dynamic> json) =>
      DeleteProductModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
