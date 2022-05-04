// To parse this JSON data, do
//
//     final meResponse = meResponseFromJson(jsonString);

import 'dart:convert';

MeResponse meResponseFromJson(String str) => MeResponse.fromJson(json.decode(str));

String meResponseToJson(MeResponse data) => json.encode(data.toJson());

class MeResponse {
    MeResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    Data? data;

    factory MeResponse.fromJson(Map<String, dynamic> json) => MeResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ||json["data"] == ''? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? null : data!.toJson(),
    };
}

class Data {
    Data({
        this.user,
        this.addresses,
    });

    User? user;
    List<Address>? addresses;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        addresses: json["addresses"] == null ? null : List<Address>.from(json["addresses"].map((x) => Address.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "user": user == null ? null : user!.toJson(),
        "addresses": addresses == null ? null : List<dynamic>.from(addresses!.map((x) => x.toJson())),
    };
}

class Address {
    Address({
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

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        userId: json["user_id"],
        zip: json["zip"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        address: json["address"],
        isDefault: json["is_default"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "zip": zip,
        "country": country,
        "state": state,
        "city": city,
        "address": address,
        "is_default": isDefault,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    };
}

class User {
    User({
        this.id,
        this.firstName,
        this.middleName,
        this.lastName,
        this.email,
        this.dob,
        this.phoneNumber,
        this.picture,
        this.city,
        this.country,
        this.state,
        this.address,
        this.code,
        this.zip,
        this.status,
        this.createdAt,
    });

    int? id;
    String? firstName;
    String? middleName;
    String? lastName;
    String? email;
    String? dob;
    String? phoneNumber;
    dynamic picture;
    String? city;
    String? country;
    String? state;
    String? address;
    String? code;
    String? zip;
    dynamic status;
    DateTime? createdAt;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        email: json["email"],
        dob: json["dob"],
        phoneNumber: json["phone_number"],
        picture: json["picture"],
        city: json["city"],
        country: json["country"],
        state: json["state"],
        address: json["address"],
        code: json["code"],
        zip: json["zip"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName??'',
        "middle_name": middleName??'',
        "last_name": lastName,
        "email": email,
        "dob": dob,
        "phone_number": phoneNumber,
        "picture": picture,
        "city": city,
        "country": country,
        "state": state,
        "address": address,
        "code": code,
        "zip": zip,
        "status": status,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    };
}
