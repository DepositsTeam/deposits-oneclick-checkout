// To parse this JSON data, do
//
//     final verifyUserResponse = verifyUserResponseFromJson(jsonString);

import 'dart:convert';

VerifyUserResponse verifyUserResponseFromJson(String str) => VerifyUserResponse.fromJson(json.decode(str));

String verifyUserResponseToJson(VerifyUserResponse data) => json.encode(data.toJson());

class VerifyUserResponse {
    VerifyUserResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    VerifyUserData? data;

    factory VerifyUserResponse.fromJson(Map<String, dynamic> json) => VerifyUserResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null||json["data"] == '' || json["data"] == "" ? null : VerifyUserData.fromJson(json[ "data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? null : data!.toJson(),
    };
}

class VerifyUserData {
    VerifyUserData({
        this.token,
    });

    String? token;

    factory VerifyUserData.fromJson(Map<String, dynamic> json) => VerifyUserData(
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
    };
}
