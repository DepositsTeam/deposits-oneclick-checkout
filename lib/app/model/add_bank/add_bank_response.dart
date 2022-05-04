// To parse this JSON data, do
//
//     final addBankResponse = addBankResponseFromJson(jsonString);

import 'dart:convert';

AddBankResponse addBankResponseFromJson(String str) =>
    AddBankResponse.fromJson(json.decode(str));

String addBankResponseToJson(AddBankResponse data) =>
    json.encode(data.toJson());

class AddBankResponse {
  AddBankResponse({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  String? data;

  factory AddBankResponse.fromJson(Map<String, dynamic> json) =>
      AddBankResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null || json["data"] == '' ? null : json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data,
      };
}
