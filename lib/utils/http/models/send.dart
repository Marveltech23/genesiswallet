import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Send {
  int userId;
  String fromAssetId;
  String fromAddress;
  String toAssetId;
  String toAddress;
  String coinAmount;
  double dollarAmount;
  double feeCoin;
  double feeDollar;
  String type;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  Send({
    required this.userId,
    required this.fromAssetId,
    required this.fromAddress,
    required this.toAssetId,
    required this.toAddress,
    required this.coinAmount,
    required this.dollarAmount,
    required this.feeCoin,
    required this.feeDollar,
    required this.type,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Send.fromJson(Map<String, dynamic> json) => Send(
        userId: json["user_id"],
        fromAssetId: json["from_asset_id"],
        fromAddress: json["from_address"],
        toAssetId: json["to_asset_id"],
        toAddress: json["to_address"],
        coinAmount: json["coin_amount"],
        dollarAmount: json["dollar_amount"]?.toDouble(),
        feeCoin: json["fee_coin"]?.toDouble(),
        feeDollar: json["fee_dollar"]?.toDouble(),
        type: json["type"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "from_asset_id": fromAssetId,
        "from_address": fromAddress,
        "to_asset_id": toAssetId,
        "to_address": toAddress,
        "coin_amount": coinAmount,
        "dollar_amount": dollarAmount,
        "fee_coin": feeCoin,
        "fee_dollar": feeDollar,
        "type": type,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}

Future<Send?> sendAsset(String from, String fromAddress, String to,
    String toAddress, String amount) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  if (token == null) {
    print('No token found');
    return null;
  }

  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/x-www-form-urlencoded',
    'Authorization': 'Bearer $token',
  };

  var request = http.Request(
      'POST', Uri.parse('https://app.trustforge.cc/api/send-asset'));

  request.bodyFields = {
    'from': from,
    'from_address': fromAddress,
    'to': to,
    'to_address': toAddress,
    'amount': amount,
  };

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String responseBody = await response.stream.bytesToString();
    return Send.fromJson(jsonDecode(responseBody));
  } else {
    print('Failed to send asset: ${response.reasonPhrase}');
    return null;
  }
}
