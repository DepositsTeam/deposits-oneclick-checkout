// To parse this JSON data, do
//
//     final linkedResponse = linkedResponseFromJson(jsonString);

import 'dart:convert';

LinkedResponse linkedResponseFromJson(String str) => LinkedResponse.fromJson(json.decode(str));

String linkedResponseToJson(LinkedResponse data) => json.encode(data.toJson());

class LinkedResponse {
    LinkedResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    LinkedData? data;

    factory LinkedResponse.fromJson(Map<String, dynamic> json) => LinkedResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ||json["data"] == '' ? null : LinkedData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
    };
}

class LinkedData {
    LinkedData({
        this.tenants,
    });

    List<Tenant>? tenants;

    factory LinkedData.fromJson(Map<String, dynamic> json) => LinkedData(
        tenants: json["tenants"] == null ? null : List<Tenant>.from(json["tenants"].map((x) => Tenant.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "tenants": tenants == null ? null : List<dynamic>.from(tenants!.map((x) => x.toJson())),
    };
}

class Tenant {
    Tenant({
        this.email,
        this.userId,
        this.name,
        this.logo,
        this.website,
        this.access,
        this.text,
        this.createdAt,
    });

    String? email;
    int? userId;
    String? name;
    String? logo;
    String? website;
    String? access;
    String? text;
    DateTime? createdAt;

    factory Tenant.fromJson(Map<String, dynamic> json) => Tenant(
        email: json["email"] == null ? null : json["email"],
        userId: json["user_id"] == null ? null : json["user_id"],
        name: json["name"] == null ? null : json["name"],
        logo: json["logo"] == null ? null : json["logo"],
        website: json["website"] == null ? null : json["website"],
        access: json["access"] == null ? null : json["access"],
        text: json["text"] == null ? null : json["text"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "user_id": userId == null ? null : userId,
        "name": name == null ? null : name,
        "logo": logo == null ? null : logo,
        "website": website== null? null : website,
        "access": access == null ? null : access,
        "text": text == null ? null : text,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    };
}
