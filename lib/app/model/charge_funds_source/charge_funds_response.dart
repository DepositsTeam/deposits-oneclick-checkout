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

  factory ChargeFundResponse.fromJson(Map<String, dynamic> json) =>
      ChargeFundResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : ChargeFundData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class ChargeFundData {
  ChargeFundData({
    this.amount,
    this.merchantName,
    this.reference,
    this.transactionId,
  });

  String? amount;
  String? merchantName;
  String? reference;
  String? transactionId;

  factory ChargeFundData.fromJson(Map<String, dynamic> json) => ChargeFundData(
        amount: json["amount"] == null ? null : json["amount"],
        merchantName:
            json["merchant_name"] == null ? null : json["merchant_name"],
        reference: json["reference"] == null ? null : json["reference"],
        transactionId:
            json["transaction_id"] == null ? null : json["transaction_id"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount == null ? null : amount,
        "merchant_name": merchantName == null ? null : merchantName,
        "reference": reference == null ? null : reference,
        "transaction_id": transactionId == null ? null : transactionId,
      };
}

