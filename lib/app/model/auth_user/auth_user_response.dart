// To parse this JSON data, do
//
//     final authUserResponse = authUserResponseFromJson(jsonString);

import 'dart:convert';

AuthUserResponse authUserResponseFromJson(String str) => AuthUserResponse.fromJson(json.decode(str));

String authUserResponseToJson(AuthUserResponse data) => json.encode(data.toJson());

class AuthUserResponse {
    AuthUserResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    List<dynamic>? data;

    factory AuthUserResponse.fromJson(Map<String, dynamic> json) => AuthUserResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<dynamic>.from(json["data"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x)),
    };
}
