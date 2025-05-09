// To parse this JSON data, do
//
//     final depositRequest = depositRequestFromJson(jsonString);

import 'dart:convert';

DepositRequest depositRequestFromJson(String str) =>
    DepositRequest.fromJson(json.decode(str));

String depositRequestToJson(DepositRequest data) => json.encode(data.toJson());

class DepositRequest {
  String status;
  String message;
  Data data;

  DepositRequest({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DepositRequest.fromJson(Map<String, dynamic> json) => DepositRequest(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  int userId;
  String assetId;
  String addressId;
  String coinAmount;
  double dollarAmount;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  Data({
    required this.userId,
    required this.assetId,
    required this.addressId,
    required this.coinAmount,
    required this.dollarAmount,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        assetId: json["asset_id"],
        addressId: json["address_id"],
        coinAmount: json["coin_amount"],
        dollarAmount: json["dollar_amount"]?.toDouble(),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "asset_id": assetId,
        "address_id": addressId,
        "coin_amount": coinAmount,
        "dollar_amount": dollarAmount,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
