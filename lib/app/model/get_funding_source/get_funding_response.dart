// To parse this JSON data, do
//
//     final getFundingResponse = getFundingResponseFromJson(jsonString);

import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

GetFundingResponse getFundingResponseFromJson(String str) => GetFundingResponse.fromJson(json.decode(str));

String getFundingResponseToJson(GetFundingResponse data) => json.encode(data.toJson());

class GetFundingResponse {
    GetFundingResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    GetFundingData? data;

    factory GetFundingResponse.fromJson(Map<String, dynamic> json) => GetFundingResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ||json["data"] == '' ? null : GetFundingData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
    };
}

class GetFundingData {
    GetFundingData({
        this.cards,
        this.bankAccounts,
    });

    List<Cards>? cards;
    List<BankAccount>? bankAccounts;

    factory GetFundingData.fromJson(Map<String, dynamic> json) => GetFundingData(
        cards: json["cards"] == null ? null : List<Cards>.from(json["cards"].map((x) => Cards.fromJson(x))),
        bankAccounts: json["bank_accounts"] == null ? null : List<BankAccount>.from(json["bank_accounts"].map((x) => BankAccount.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "cards": cards == null ? null : List<dynamic>.from(cards!.map((x) => x.toJson())),
        "bank_accounts": bankAccounts == null ? null : List<dynamic>.from(bankAccounts!.map((x) => x.toJson())),
    };
}
