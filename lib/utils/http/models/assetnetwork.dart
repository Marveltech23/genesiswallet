class AssetResponse {
  String status;
  String message;
  List<AssetData> data;

  AssetResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AssetResponse.fromJson(Map<String, dynamic> json) => AssetResponse(
        status: json["status"],
        message: json["message"],
        data: List<AssetData>.from(
            json["data"].map((x) => AssetData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AssetData {
  int id;
  String address;
  Network network;

  AssetData({
    required this.id,
    required this.address,
    required this.network,
  });

  factory AssetData.fromJson(Map<String, dynamic> json) => AssetData(
        id: json["id"],
        address: json["address"],
        network: Network.fromJson(json["network"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "network": network.toJson(),
      };
}

class Network {
  int id;
  String name;
  String symbol;
  String logo;
  String dollarRate;
  NetworkDetail network;

  Network({
    required this.id,
    required this.name,
    required this.symbol,
    required this.logo,
    required this.dollarRate,
    required this.network,
  });

  factory Network.fromJson(Map<String, dynamic> json) => Network(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
        logo: json["logo"],
        dollarRate: json["dollar_rate"],
        network: NetworkDetail.fromJson(json["network"]),
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

class NetworkDetail {
  int id;
  String name;
  String symbol;
  String logo;

  NetworkDetail({
    required this.id,
    required this.name,
    required this.symbol,
    required this.logo,
  });

  factory NetworkDetail.fromJson(Map<String, dynamic> json) => NetworkDetail(
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
