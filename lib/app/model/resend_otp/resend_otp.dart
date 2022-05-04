// To parse this JSON data, do
//
//     final resendOtpResponse = resendOtpResponseFromJson(jsonString);

import 'dart:convert';

ResendOtpResponse resendOtpResponseFromJson(String str) => ResendOtpResponse.fromJson(json.decode(str));

String resendOtpResponseToJson(ResendOtpResponse data) => json.encode(data.toJson());

class ResendOtpResponse {
    ResendOtpResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    List<dynamic>? data;

    factory ResendOtpResponse.fromJson(Map<String, dynamic> json) => ResendOtpResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ||json["data"] == ''? null : List<dynamic>.from(json["data"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x)),
    };
}
