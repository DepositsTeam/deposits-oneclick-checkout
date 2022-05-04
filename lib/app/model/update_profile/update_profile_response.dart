// To parse this JSON data, do
//
//     final updateProfileResponse = updateProfileResponseFromJson(jsonString);

import 'dart:convert';

UpdateProfileResponse updateProfileResponseFromJson(String str) => UpdateProfileResponse.fromJson(json.decode(str));

String updateProfileResponseToJson(UpdateProfileResponse data) => json.encode(data.toJson());

class UpdateProfileResponse {
    UpdateProfileResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    Data? data;

    factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) => UpdateProfileResponse(
        status: json["status"],
        message: json["message"],
        data:json["data"] == null ||json["data"] == '' || json["data"] ==  "" ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data":data == null ? null : data!.toJson(),
    };
}

class Data {
    Data({
        this.user,
    });

    User? user;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
    };
}

class User {
    User({
        this.id,
        this.firstName,
        this.middleName,
        this.lastName,
        this.email,
        this.dob,
        this.phoneNumber,
        this.picture,
        this.city,
        this.country,
        this.state,
        this.address,
        this.code,
        this.zip,
        this.status,
        this.createdAt,
    });

    int? id;
    String? firstName;
    String? middleName;
    String? lastName;
    String? email;
    String? dob;
    String? phoneNumber;
    dynamic picture;
    String? city;
    String? country;
    String? state;
    String? address;
    String? code;
    String? zip;
    dynamic status;
    String? createdAt;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        email: json["email"],
        dob: json["dob"],
        phoneNumber: json["phone_number"],
        picture: json["picture"],
        city: json["city"],
        country: json["country"],
        state: json["state"],
        address: json["address"],
        code: json["code"],
        zip: json["zip"],
        status: json["status"],
        createdAt: json["created_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "email": email,
        "dob": dob,
        "phone_number": phoneNumber,
        "picture": picture,
        "city": city,
        "country": country,
        "state": state,
        "address": address,
        "code": code,
        "zip": zip,
        "status": status,
        "created_at": createdAt,
    };
}
