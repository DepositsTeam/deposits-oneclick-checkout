class Issuer {
  Issuer({
    this.cardNumber,
    this.brand,
    this.cardType,
    this.bankName,
    this.country,
  });

  String? cardNumber;
  String? brand;
  String? cardType;
  String? bankName;
  String? country;

  factory Issuer.fromJson(Map<String, dynamic> json) => Issuer(
        cardNumber: json["Card_Number"] == null ? null : json["Card_Number"],
        brand: json["Brand"] == null ? null : json["Brand"],
        cardType: json["Card_Type"] == null ? null : json["Card_Type"],
        bankName: json["Bank_Name"] == null ? null : json["Bank_Name"],
        country: json["Country"] == null ? null : json["Country"],
      );

  Map<String, dynamic> toJson() => {
        "Card_Number": cardNumber == null ? null : cardNumber,
        "Brand": brand == null ? null : brand,
        "Card_Type": cardType == null ? null : cardType,
        "Bank_Name": bankName == null ? null : bankName,
        "Country": country == null ? null : country,
      };
}
