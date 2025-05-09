import 'dart:convert';

class Transaction {
  final int id;
  final String type;
  final Asset fromAsset;
  final String fromAddress;
  final Asset toAsset;
  final String toAddress;
  final String coinAmount;
  final String dollarAmount;
  final String feeCoin;
  final String feeDollar;
  final String toAmount;
  final String toDollar;
  final String status;
  final DateTime date;

  Transaction({
    required this.id,
    required this.type,
    required this.fromAsset,
    required this.fromAddress,
    required this.toAsset,
    required this.toAddress,
    required this.coinAmount,
    required this.dollarAmount,
    required this.feeCoin,
    required this.feeDollar,
    required this.toAmount,
    required this.toDollar,
    required this.status,
    required this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      type: json['type'],
      fromAsset: Asset.fromJson(json['from_asset']),
      fromAddress: json['from_address'],
      toAsset: Asset.fromJson(json['to_asset']),
      toAddress: json['to_address'],
      coinAmount: json['coin_amount'],
      dollarAmount: json['dollar_amount'],
      feeCoin: json['fee_coin'],
      feeDollar: json['fee_dollar'],
      toAmount: json['to_amount'],
      toDollar: json['to_dollar'],
      status: json['status'],
      date: DateTime.parse(json['date']),
    );
  }
}

class Asset {
  final int id;
  final String name;
  final String symbol;
  final String logo;
  final String dollarRate;
  final Network network;

  Asset({
    required this.id,
    required this.name,
    required this.symbol,
    required this.logo,
    required this.dollarRate,
    required this.network,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      logo: json['logo'],
      dollarRate: json['dollar_rate'],
      network: Network.fromJson(json['network']),
    );
  }
}

class Network {
  final int id;
  final String name;
  final String symbol;
  final String logo;

  Network({
    required this.id,
    required this.name,
    required this.symbol,
    required this.logo,
  });

  factory Network.fromJson(Map<String, dynamic> json) {
    return Network(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      logo: json['logo'],
    );
  }
}
