// To parse this JSON data, do
//
//     final setDefaultAddressResponse = setDefaultAddressResponseFromJson(jsonString);

import 'dart:convert';

SetDefaultAddressResponse setDefaultAddressResponseFromJson(String str) => SetDefaultAddressResponse.fromJson(json.decode(str));

String setDefaultAddressResponseToJson(SetDefaultAddressResponse data) => json.encode(data.toJson());

class SetDefaultAddressResponse {
    SetDefaultAddressResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    SetDefaultAddressData? data;

    factory SetDefaultAddressResponse.fromJson(Map<String, dynamic> json) => SetDefaultAddressResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : SetDefaultAddressData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
    };
}

class SetDefaultAddressData {
    SetDefaultAddressData({
        this.id,
        this.userId,
        this.zip,
        this.country,
        this.state,
        this.city,
        this.address,
        this.isDefault,
        this.status,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? userId;
    String? zip;
    String? country;
    String? state;
    String? city;
    String? address;
    String? isDefault;
    String? status;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory SetDefaultAddressData.fromJson(Map<String, dynamic> json) => SetDefaultAddressData(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        zip: json["zip"] == null ? null : json["zip"],
        country: json["country"] == null ? null : json["country"],
        state: json["state"] == null ? null : json["state"],
        city: json["city"] == null ? null : json["city"],
        address: json["address"] == null ? null : json["address"],
        isDefault: json["is_default"] == null ? null : json["is_default"],
        status: json["status"] == null ? null : json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "zip": zip == null ? null : zip,
        "country": country == null ? null : country,
        "state": state == null ? null : state,
        "city": city == null ? null : city,
        "address": address == null ? null : address,
        "is_default": isDefault == null ? null : isDefault,
        "status": status == null ? null : status,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    };
}
