
import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class MetaDataJson {
  MetaDataJson({
    this.status,
    this.responseCode,
    this.responseMessage,
    this.token,
    this.expirationDate,
    this.cardType,
    this.maskedCardNumber,
    this.cardTransactionIdentifier,
    this.taskId,
    this.transactionId,
    this.transactionTimestamp,
    this.expiration,
    this.cvv,
    this.fullName,
    this.issuer,
  });

  String? status;
  String? responseCode;
  String? responseMessage;
  String? token;
  String? expirationDate;
  String? cardType;
  String? maskedCardNumber;
  String? cardTransactionIdentifier;
  String? taskId;
  String? transactionId;
  DateTime? transactionTimestamp;
  String? expiration;
  String? cvv;
  String? fullName;
  List<Issuer>? issuer;

  factory MetaDataJson.fromJson(Map<String, dynamic> json) => MetaDataJson(
        status: json["status"] == null ? null : json["status"],
        responseCode:
            json["responseCode"] == null ? null : json["responseCode"],
        responseMessage:
            json["responseMessage"] == null ? null : json["responseMessage"],
        token: json["token"] == null ? null : json["token"],
        expirationDate:
            json["expirationDate"] == null ? null : json["expirationDate"],
        cardType: json["cardType"] == null ? null : json["cardType"],
        maskedCardNumber:
            json["maskedCardNumber"] == null ? null : json["maskedCardNumber"],
        cardTransactionIdentifier: json["cardTransactionIdentifier"] == null
            ? null
            : json["cardTransactionIdentifier"],
        taskId: json["taskID"] == null ? null : json["taskID"],
        transactionId:
            json["transactionID"] == null ? null : json["transactionID"],
        transactionTimestamp: json["transactionTimestamp"] == null
            ? null
            : DateTime.parse(json["transactionTimestamp"]),
        expiration: json["expiration"] == null ? null : json["expiration"],
        cvv: json["cvv"] == null ? null : json["cvv"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        issuer: json["issuer"] == null
            ? null
            : List<Issuer>.from(json["issuer"].map((x) => Issuer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "responseCode": responseCode == null ? null : responseCode,
        "responseMessage": responseMessage == null ? null : responseMessage,
        "token": token == null ? null : token,
        "expirationDate": expirationDate == null ? null : expirationDate,
        "cardType": cardType == null ? null : cardType,
        "maskedCardNumber": maskedCardNumber == null ? null : maskedCardNumber,
        "cardTransactionIdentifier": cardTransactionIdentifier == null
            ? null
            : cardTransactionIdentifier,
        "taskID": taskId == null ? null : taskId,
        "transactionID": transactionId == null ? null : transactionId,
        "transactionTimestamp": transactionTimestamp == null
            ? null
            : transactionTimestamp!.toIso8601String(),
        "expiration": expiration == null ? null : expiration,
        "cvv": cvv == null ? null : cvv,
        "full_name": fullName == null ? null : fullName,
        "issuer": issuer == null
            ? null
            : List<dynamic>.from(issuer!.map((x) => x.toJson())),
      };
}
