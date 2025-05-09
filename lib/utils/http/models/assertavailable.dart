// To parse this JSON data, do
//
//     final assetAvailable = assetAvailableFromJson(jsonString);

import 'dart:convert';

AssetAvailable assetAvailableFromJson(String str) =>
    AssetAvailable.fromJson(json.decode(str));

String assetAvailableToJson(AssetAvailable data) => json.encode(data.toJson());

class AssetAvailable {
  String status;
  String message;
  List<Datum> data;

  AssetAvailable({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AssetAvailable.fromJson(Map<String, dynamic> json) => AssetAvailable(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String name;
  String symbol;
  String logo;

  Datum({
    required this.id,
    required this.name,
    required this.symbol,
    required this.logo,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
