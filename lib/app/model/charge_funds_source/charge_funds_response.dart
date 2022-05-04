// To parse this JSON data, do
//
//     final chargeFundResponse = chargeFundResponseFromJson(jsonString);

import 'dart:convert';

ChargeFundResponse chargeFundResponseFromJson(String str) => ChargeFundResponse.fromJson(json.decode(str));

String chargeFundResponseToJson(ChargeFundResponse data) => json.encode(data.toJson());

class ChargeFundResponse {
    ChargeFundResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    ChargeFundData? data;

    factory ChargeFundResponse.fromJson(Map<String, dynamic> json) => ChargeFundResponse(
        status: json["status"],
        message: json["message"],
        data:json["data"] == null || json["data"] == "" ? null : ChargeFundData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data":data == null ? null : data!.toJson(),
    };
}

class ChargeFundData {
    ChargeFundData({
        this.amount,
        this.merchantName,
        this.transactionId,
    });

    String? amount;
    String? merchantName;
    String? transactionId;

    factory ChargeFundData.fromJson(Map<String, dynamic> json) => ChargeFundData(
        amount: json["amount"],
        merchantName: json["merchant_name"],
        transactionId: json["transaction_id"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "merchant_name": merchantName,
        "transaction_id": transactionId
    };
}

