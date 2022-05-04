import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class Cards {
  Cards({
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
  String? primaryCard;
  String? status;
  String? cardOwnerName;
  String? cardOwnerEmail;
  String? cardOwnerPhone;
  MetaDataJson? metaDataJson;
  DateTime? createdAt;

  factory Cards.fromJson(Map<String, dynamic> json) => Cards(
        id: json["id"] == null ? null : json["id"],
        authCode: json["auth_code"] == null ? null : json["auth_code"],
        primaryCard: json["primary_card"] == null ? null : json["primary_card"],
        status: json["status"] == null ? null : json["status"],
        cardOwnerName:
            json["card_owner_name"] == null ? null : json["card_owner_name"],
        cardOwnerEmail:
            json["card_owner_email"] == null ? null : json["card_owner_email"],
        cardOwnerPhone:
            json["card_owner_phone"] == null ? null : json["card_owner_phone"],
        metaDataJson: json["meta_data_json"] == null
            ? null
            : MetaDataJson.fromJson(json["meta_data_json"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "auth_code": authCode == null ? null : authCode,
        "primary_card": primaryCard == null ? null : primaryCard,
        "status": status == null ? null : status,
        "card_owner_name": cardOwnerName == null ? null : cardOwnerName,
        "card_owner_email": cardOwnerEmail == null ? null : cardOwnerEmail,
        "card_owner_phone": cardOwnerPhone == null ? null : cardOwnerPhone,
        "meta_data_json": metaDataJson == null ? null : metaDataJson!.toJson(),
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
      };
}
