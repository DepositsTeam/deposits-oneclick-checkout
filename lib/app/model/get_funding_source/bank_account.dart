class BankAccount {
  BankAccount({
    this.id,
    this.type,
    this.bank,
    this.accountName,
    this.accountType,
    this.accountNumber,
    this.routingNumber,
    this.accountLimit,
    this.status,
    this.accountOwnerName,
    this.accountOwnerEmail,
    this.accountOwnerPhone,
    this.createdAt,
  });

  int? id;
  dynamic type;
  String? bank;
  String? accountName;
  String? accountType;
  String? accountNumber;
  String? routingNumber;
  dynamic accountLimit;
  String? status;
  String? accountOwnerName;
  String? accountOwnerEmail;
  String? accountOwnerPhone;
  DateTime? createdAt;

  factory BankAccount.fromJson(Map<String, dynamic> json) => BankAccount(
        id: json["id"] == null ? null : json["id"],
        type: json["type"],
        bank: json["bank"] == null ? null : json["bank"],
        accountName: json["account_name"] == null ? null : json["account_name"],
        accountType: json["account_type"] == null ? null : json["account_type"],
        accountNumber:
            json["account_number"] == null ? null : json["account_number"],
        routingNumber:
            json["routing_number"] == null ? null : json["routing_number"],
        accountLimit: json["account_limit"],
        status: json["status"] == null ? null : json["status"],
        accountOwnerName: json["account_owner_name"] == null
            ? null
            : json["account_owner_name"],
        accountOwnerEmail: json["account_owner_email"] == null
            ? null
            : json["account_owner_email"],
        accountOwnerPhone: json["account_owner_phone"] == null
            ? null
            : json["account_owner_phone"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type,
        "bank": bank == null ? null : bank,
        "account_name": accountName == null ? null : accountName,
        "account_type": accountType == null ? null : accountType,
        "account_number": accountNumber == null ? null : accountNumber,
        "routing_number": routingNumber == null ? null : routingNumber,
        "account_limit": accountLimit,
        "status": status == null ? null : status,
        "account_owner_name":
            accountOwnerName == null ? null : accountOwnerName,
        "account_owner_email":
            accountOwnerEmail == null ? null : accountOwnerEmail,
        "account_owner_phone":
            accountOwnerPhone == null ? null : accountOwnerPhone,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
      };
}
