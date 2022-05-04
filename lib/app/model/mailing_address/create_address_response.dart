// To parse this JSON data, do
//
//     final createAddressResponse = createAddressResponseFromJson(jsonString);

import 'dart:convert';

CreateAddressResponse createAddressResponseFromJson(String str) => CreateAddressResponse.fromJson(json.decode(str));

String createAddressResponseToJson(CreateAddressResponse data) => json.encode(data.toJson());

class CreateAddressResponse {
    CreateAddressResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    CreateAddressData? data;

    factory CreateAddressResponse.fromJson(Map<String, dynamic> json) => CreateAddressResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ||json["data"] == '' ? null : CreateAddressData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
    };
}

class CreateAddressData {
    CreateAddressData({
        this.userId,
        this.zip,
        this.country,
        this.state,
        this.city,
        this.address,
        this.isDefault,
        this.status,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    int? userId;
    String? zip;
    String? country;
    String? state;
    String? city;
    String? address;
    String? isDefault;
    String? status;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    factory CreateAddressData.fromJson(Map<String, dynamic> json) => CreateAddressData(
        userId: json["user_id"] == null ? null : json["user_id"],
        zip: json["zip"] == null ? null : json["zip"],
        country: json["country"] == null ? null : json["country"],
        state: json["state"] == null ? null : json["state"],
        city: json["city"] == null ? null : json["city"],
        address: json["address"] == null ? null : json["address"],
        isDefault: json["is_default"] == null ? null : json["is_default"],
        status: json["status"] == null ? null : json["status"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"] == null ? null : json["id"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "zip": zip == null ? null : zip,
        "country": country == null ? null : country,
        "state": state == null ? null : state,
        "city": city == null ? null : city,
        "address": address == null ? null : address,
        "is_default": isDefault == null ? null : isDefault,
        "status": status == null ? null : status,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "id": id == null ? null : id,
    };
}
