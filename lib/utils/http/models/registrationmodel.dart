// To parse this JSON data, do
//
//     final registerDataModel = registerDataModelFromJson(jsonString);

import 'dart:convert';

RegisterDataModel registerDataModelFromJson(String str) =>
    RegisterDataModel.fromJson(json.decode(str));

String registerDataModelToJson(RegisterDataModel data) =>
    json.encode(data.toJson());

class RegisterDataModel {
  String status;
  String message;
  Data data;

  RegisterDataModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RegisterDataModel.fromJson(Map<String, dynamic> json) =>
      RegisterDataModel(
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
  String token;
  User user;

  Data({
    required this.token,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
      };
}

class User {
  int? id;
  String? nickname;
  String userip;
  String deviceId;
  int totalAssetAmount;
  List<Asset> assets;
  List<dynamic> transactions;

  User({
    this.id,
    this.nickname,
    required this.userip,
    required this.deviceId,
    required this.totalAssetAmount,
    required this.assets,
    required this.transactions,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        nickname: json["nickname"],
        userip: json["userip"],
        deviceId: json["device_id"],
        totalAssetAmount: json["total_asset_amount"],
        assets: List<Asset>.from(json["assets"].map((x) => Asset.fromJson(x))),
        transactions: List<dynamic>.from(json["transactions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nickname": nickname,
        "userip": userip,
        "device_id": deviceId,
        "total_asset_amount": totalAssetAmount,
        "assets": List<dynamic>.from(assets.map((x) => x.toJson())),
        "transactions": List<dynamic>.from(transactions.map((x) => x)),
      };
}

class Asset {
  int id;
  String name;
  String symbol;
  String logo;
  String dollarRate;
  String userCoinBalance;
  String balanceDollarRate;

  Asset({
    required this.id,
    required this.name,
    required this.symbol,
    required this.logo,
    required this.dollarRate,
    required this.userCoinBalance,
    required this.balanceDollarRate,
  });

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
        logo: json["logo"],
        dollarRate: json["dollar_rate"],
        userCoinBalance: json["user_coin_balance"],
        balanceDollarRate: json["balance_dollar_rate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "symbol": symbol,
        "logo": logo,
        "dollar_rate": dollarRate,
        "user_coin_balance": userCoinBalance,
        "balance_dollar_rate": balanceDollarRate,
      };
}
