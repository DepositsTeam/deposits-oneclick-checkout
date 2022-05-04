// To parse this JSON data, do
//
//     final tokenizeCardResponse = tokenizeCardResponseFromJson(jsonString);

import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

TokenizeCardResponse tokenizeCardResponseFromJson(String str) => TokenizeCardResponse.fromJson(json.decode(str));

String tokenizeCardResponseToJson(TokenizeCardResponse data) => json.encode(data.toJson());

class TokenizeCardResponse {
    TokenizeCardResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    TokenizeCardData? data;

    factory TokenizeCardResponse.fromJson(Map<String, dynamic> json) => TokenizeCardResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null||json["data"] == '' || json["data"] ==  "" ? null : TokenizeCardData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? null : data!.toJson(),
    };
}

class TokenizeCardData {
    TokenizeCardData({
        this.id,
        this.authCode,
        this.primaryCard,
        this.status,
        this.cardOwnerName,
        this.cardOwnerEmail,
        this.cardOwnerPhone,
        this.metaDataJson,
        this.createdAt,
    });

    int? id;
    String? authCode;
    dynamic primaryCard;
    String? status;
    String? cardOwnerName;
    String? cardOwnerEmail;
    String? cardOwnerPhone;
    MetaDataJson? metaDataJson;
    String? createdAt;

    factory TokenizeCardData.fromJson(Map<String, dynamic> json) => TokenizeCardData(
        id: json["id"],
        authCode: json["auth_code"],
        primaryCard: json["primary_card"],
        status: json["status"],
        cardOwnerName: json["card_owner_name"],
        cardOwnerEmail: json["card_owner_email"],
        cardOwnerPhone: json["card_owner_phone"],
        metaDataJson: MetaDataJson.fromJson(json["meta_data_json"]),
        createdAt: json["created_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "auth_code": authCode,
        "primary_card": primaryCard,
        "status": status,
        "card_owner_name": cardOwnerName,
        "card_owner_email": cardOwnerEmail,
        "card_owner_phone": cardOwnerPhone,
        "meta_data_json": metaDataJson!.toJson(),
        "created_at": createdAt,
    };
}
