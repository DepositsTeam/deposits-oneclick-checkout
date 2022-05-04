// To parse this JSON data, do
//
//     final allAccountsResponse = allAccountsResponseFromJson(jsonString);

import 'dart:convert';

AllAccountsResponse allAccountsResponseFromJson(String str) => AllAccountsResponse.fromJson(json.decode(str));

String allAccountsResponseToJson(AllAccountsResponse data) => json.encode(data.toJson());

class AllAccountsResponse {
    AllAccountsResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    Data? data;

    factory AllAccountsResponse.fromJson(Map<String, dynamic> json) => AllAccountsResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null || json["data"] == "" ? null: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data==null? null: data!.toJson(),
    };
}

class Data {
    Data({
        this.tenants,
    });

    List<Tenant>? tenants;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        tenants: List<Tenant>.from(json["tenants"].map((x) => Tenant.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "tenants": List<dynamic>.from(tenants!.map((x) => x.toJson())),
    };
}

class Tenant {
    Tenant({
        this.email,
        this.userId,
        this.name,
        this.logo,
        this.access,
    });

    String? email;
    int? userId;
    String? name;
    String? logo;
    String? access;

    factory Tenant.fromJson(Map<String, dynamic> json) => Tenant(
        email: json["email"],
        userId: json["user_id"],
        name: json["name"],
        logo: json["logo"],
        access: json["access"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "user_id": userId,
        "name": name,
        "logo": logo,
        "access": access,
    };
}
