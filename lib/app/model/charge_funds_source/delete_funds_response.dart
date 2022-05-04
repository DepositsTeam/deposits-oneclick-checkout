// To parse this JSON data, do
//
//     final deleteFundSourceResponse = deleteFundSourceResponseFromJson(jsonString);

import 'dart:convert';

DeleteFundSourceResponse deleteFundSourceResponseFromJson(String str) => DeleteFundSourceResponse.fromJson(json.decode(str));

String deleteFundSourceResponseToJson(DeleteFundSourceResponse data) => json.encode(data.toJson());

class DeleteFundSourceResponse {
    DeleteFundSourceResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    List<dynamic>? data;

    factory DeleteFundSourceResponse.fromJson(Map<String, dynamic> json) => DeleteFundSourceResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ||json["data"] == '' ? null : List<dynamic>.from(json["data"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x)),
    };
}
