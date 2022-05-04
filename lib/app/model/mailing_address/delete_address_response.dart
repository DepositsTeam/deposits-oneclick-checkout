// To parse this JSON data, do
//
//     final deleteAddressResponse = deleteAddressResponseFromJson(jsonString);

import 'dart:convert';

DeleteAddressResponse deleteAddressResponseFromJson(String str) => DeleteAddressResponse.fromJson(json.decode(str));

String deleteAddressResponseToJson(DeleteAddressResponse data) => json.encode(data.toJson());

class DeleteAddressResponse {
    DeleteAddressResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    String? data;

    factory DeleteAddressResponse.fromJson(Map<String, dynamic> json) => DeleteAddressResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ||json["data"] == ''? null : json["data"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data,
    };
}
