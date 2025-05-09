// To parse this JSON data, do
//
//     final userAddress = userAddressFromJson(jsonString);

import 'dart:convert';

UserAddress userAddressFromJson(String str) =>
    UserAddress.fromJson(json.decode(str));

String userAddressToJson(UserAddress data) => json.encode(data.toJson());

class UserAddress {
  String status;
  String message;
  Data data;

  UserAddress({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
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
  int id;
  String address;
  DataNetwork network;

  Data({
    required this.id,
    required this.address,
    required this.network,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        address: json["address"],
        network: DataNetwork.fromJson(json["network"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "network": network.toJson(),
      };
}

class DataNetwork {
  int id;
  String name;
  String symbol;
  String logo;
  String dollarRate;
  NetworkNetwork network;

  DataNetwork({
    required this.id,
    required this.name,
    required this.symbol,
    required this.logo,
    required this.dollarRate,
    required this.network,
  });

  factory DataNetwork.fromJson(Map<String, dynamic> json) => DataNetwork(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
        logo: json["logo"],
        dollarRate: json["dollar_rate"],
        network: NetworkNetwork.fromJson(json["network"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "symbol": symbol,
        "logo": logo,
        "dollar_rate": dollarRate,
        "network": network.toJson(),
      };
}

class NetworkNetwork {
  int id;
  String name;
  String symbol;
  String logo;

  NetworkNetwork({
    required this.id,
    required this.name,
    required this.symbol,
    required this.logo,
  });

  factory NetworkNetwork.fromJson(Map<String, dynamic> json) => NetworkNetwork(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "symbol": symbol,
        "logo": logo,
      };
}
